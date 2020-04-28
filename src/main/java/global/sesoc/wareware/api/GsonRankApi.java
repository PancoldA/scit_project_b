package global.sesoc.wareware.api;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

public class GsonRankApi {

	static public class NameEntity {

		final String text;
		final String type;
		Integer count;

		public NameEntity(String text, String type, Integer count) {

			this.text = text;
			this.type = type;
			this.count = count;

		}

	}

	static public class Morpheme {
		final String text;
		final String type;
		Integer count;

		public Morpheme(String text, String type, Integer count) {
			this.text = text;
			this.type = type;
			this.count = count;
		}
	}

	private static final Logger logger = LoggerFactory.getLogger(GsonRankApi.class);
	private final static String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU"; // 오픈api url
	private final static String accessKey = "bde44255-e535-46c3-b7e6-16567e506ee1"; // 발급받은 API Key

	public List<String> languageRankAnalysis(String text) {

		logger.info("GsonApi languageRankAnalysis Method");

		Gson gson = new Gson();

		Map<String, Object> request = new HashMap<>();
		Map<String, String> argument = new HashMap<>();

//		analysis_Code
//		morp : 헝태소 분석
//		wsd : 어휘분석_동음이의어
//		wsd_poly : 어휘분석_다의어
//		ner : 개체명 인식
//		dparse : 의존 구문 분석
//		srl : 의미역 인식

		argument.put("analysis_code", "ner"); // 언어 분석 코드
		argument.put("text", text); // 분석한 텍스트

		request.put("access_key", accessKey);
		request.put("argument", argument);

		URL url;
		Integer responseCode = null;
		String responBodyJson = null;
		Map<String, Object> responBody = null;
		List<String> list = new ArrayList<String>();

		try {

			url = new URL(openApiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.write(gson.toJson(request).getBytes("UTF-8"));
			wr.flush();
			wr.close();

			responseCode = con.getResponseCode();
			InputStream is = con.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			StringBuffer sb = new StringBuffer();

			String inputLine = "";

			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}

			responBodyJson = sb.toString();

			// http 요청 오류 시 처리
			if (responseCode != 200) {
				logger.info("GsonApiError http 요청 오류" + responBodyJson);
				return list;
			}

			responBody = gson.fromJson(responBodyJson, Map.class);
			Integer result = ((Double) responBody.get("result")).intValue();
			Map<String, Object> returnObject;
			List<Map> sentences;

			// 분석 요청 오류 시 처리
			if (result != 0) {
				logger.info("GsonApiError 분석 요청 오류" + responBody.get("result"));
				return list;
			}

			// 분석 결과 활용
			returnObject = (Map<String, Object>) responBody.get("return_object");
			sentences = (List<Map>) returnObject.get("sentence");

			Map<String, Morpheme> morphemesMap = new HashMap<String, Morpheme>();
			Map<String, NameEntity> nameEntitiesMap = new HashMap<String, NameEntity>();
			List<Morpheme> morphemes = null;
			List<NameEntity> nameEntities = null;

			for (Map<String, Object> sentence : sentences) {

				// 형태소 분석기 결과 수집 및 정렬
				List<Map<String, Object>> morphologicalAnalysisResult = (List<Map<String, Object>>) sentence
						.get("morp");
				for (Map<String, Object> morphemeInfo : morphologicalAnalysisResult) {
					String lemma = (String) morphemeInfo.get("lemma");
					Morpheme morpheme = morphemesMap.get(lemma);
					if (morpheme == null) {
						morpheme = new Morpheme(lemma, (String) morphemeInfo.get("type"), 1);
						morphemesMap.put(lemma, morpheme);
					} else {
						morpheme.count = morpheme.count + 1;
					}
				}

				// 개체명 분석 결과 수집 및 정렬
//				List<Map<String, Object>> nameEntityRecognitionResult = (List<Map<String, Object>>) sentence.get("NE");
//				for (Map<String, Object> nameEntityInfo : nameEntityRecognitionResult) {
//					String name = (String) nameEntityInfo.get("text");
//					NameEntity nameEntity = nameEntitiesMap.get(name);
//					if (nameEntity == null) {
//						nameEntity = new NameEntity(name, (String) nameEntityInfo.get("type"), 1);
//						nameEntitiesMap.put(name, nameEntity);
//					} else {
//						nameEntity.count = nameEntity.count + 1;
//					}
//				}

			}

			if (0 < morphemesMap.size()) {
				morphemes = new ArrayList<Morpheme>(morphemesMap.values());
				morphemes.sort((morpheme1, morpheme2) -> {
					return morpheme2.count - morpheme1.count;
				});
			}

//			if (0 < nameEntitiesMap.size()) {
//				nameEntities = new ArrayList<NameEntity>(nameEntitiesMap.values());
//				nameEntities.sort((nameEntity1, nameEntity2) -> {
//					return nameEntity2.count - nameEntity1.count;
//				});
//			}

			// 형태소들 중 명사들에 대해서 많이 노출된 순으로 출력 ( 최대 limit 개 )
			morphemes.stream().filter(morpheme -> {
				return morpheme.type.equals("NNG") || morpheme.type.equals("NNP") || morpheme.type.equals("NNB");
			}).limit(10).forEach(morpheme -> {
//				System.out.println("[명사] " + morpheme.text + " (" + morpheme.count + ")");
				list.add(morpheme.text);
			});

			// 형태소들 중 동사들에 대해서 많이 노출된 순으로 출력 ( 최대 limit 개 )
//			System.out.println("");
//			morphemes.stream().filter(morpheme -> {
//				return morpheme.type.equals("VV");
//			}).limit(10).forEach(morpheme -> {
//				System.out.println("[동사] " + morpheme.text + " (" + morpheme.count + ")");
//			});

			// 인식된 개채명들 많이 노출된 순으로 출력 ( 최대 limit 개 )
//			nameEntities.stream().limit(10).forEach(nameEntity -> {
//				System.out.println("[개체명] " + nameEntity.text + " (" + nameEntity.count + ")");
//			});

			return list;

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return list;

	}

}
