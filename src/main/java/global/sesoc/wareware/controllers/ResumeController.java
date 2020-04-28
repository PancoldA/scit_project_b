package global.sesoc.wareware.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import global.sesoc.wareware.api.GsonRankApi;
import global.sesoc.wareware.api.TFIDFCalculator;
import global.sesoc.wareware.dao.ResumeDAO;
import global.sesoc.wareware.vo.Category;
import global.sesoc.wareware.vo.Resume;

@Controller
public class ResumeController {

	@Autowired
	ResumeDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(ResumeController.class);

	@GetMapping("/resumeHome")
	public String resumeHome() {
		logger.info("ResumeController's GET resumeHome Method");
		return "resume/resumeHome";
	}

	@GetMapping("/writing")
	public String writing() {
		logger.info("ResumeController's GET writing Method");
		return "resume/writing";
	}

	@PostMapping("/saveResume")
	public String saveResume(Resume resume, HttpSession session) {
		logger.info("ResumeController's POST saveResume Method");

		String user_email = (String) session.getAttribute("loginId");
		resume.setUser_email(user_email);

		int result = dao.insertResume(resume);

		if (result > 0)
			return "redirect:/resumeList";
		else
			return "";
	}

	@PostMapping("/analysisResume")
	public String analysisResume(String category_type, String resume_content, Model model) {
		logger.info("ResumeController's POST analysisResume Method");

		GsonRankApi gsonrankapiresult = new GsonRankApi();

		List<String> list = gsonrankapiresult.languageRankAnalysis(resume_content);

		Category category = new Category();
		category.setCategory_list(category_type);

		List<String> docList = new ArrayList<String>();

		for (int i = 0; i < list.size(); i++) {

			if (list.get(0).length() < 2) {

				list.remove(i);

			}

		}

		docList.add("의사소통");
		docList.add("문제해결");
		docList.add("자원관리");
		docList.add("도전정신");
		docList.add("주체지향");

		List<String> doc1 = dao.getList(docList.get(0));
		List<String> doc2 = dao.getList(docList.get(1));
		List<String> doc3 = dao.getList(docList.get(2));
		List<String> doc4 = dao.getList(docList.get(3));
		List<String> doc5 = dao.getList(docList.get(4));

		List<List<String>> documents = Arrays.asList(doc1, doc2, doc3, doc4, doc5);

		TFIDFCalculator calculator = new TFIDFCalculator();

		List<Double> result = new ArrayList<Double>();
		Map<String, Double> tfidfResult = new HashMap<String, Double>();

		double tfidfSum = 0.0;
		double alltfidfSum = 0.0;

		for (List<String> docs : documents) {

			tfidfSum = 0.0;
			for (int i = 0; i < list.size(); i++) {

				double tfidf = calculator.tfIdf(docs, documents, list.get(i));
				tfidfSum += tfidf;
			}

			result.add(tfidfSum);
			alltfidfSum += tfidfSum;

		}

		tfidfResult.put(docList.get(0), result.get(0));
		tfidfResult.put(docList.get(1), result.get(1));
		tfidfResult.put(docList.get(2), result.get(2));
		tfidfResult.put(docList.get(3), result.get(3));
		tfidfResult.put(docList.get(4), result.get(4));

		Map<String, Double> resultMap = new HashMap<String, Double>();

		for (int i = 0; i < tfidfResult.size(); i++) {

			double persent = tfidfResult.get(docList.get(i)) / alltfidfSum;
			resultMap.put(docList.get(i), persent);

		}

		List<String> keySetList = new ArrayList<>(resultMap.keySet());
		// 내림차순 //
		Collections.sort(keySetList, new Comparator<String>() {

			@Override
			public int compare(String o1, String o2) {
				return resultMap.get(o2).compareTo(resultMap.get(o1));

			}
		});

		if (keySetList.get(0).equals(category_type)) {

			model.addAttribute("result", "success");

		} else {

			model.addAttribute("result", "fail");

		}

		Map<String, String> map = new HashMap<String, String>();

		for (int i = 0; i < keySetList.size(); i++) {

			String rank = Integer.toString(i);
			map.put(rank, keySetList.get(i));

		}

		JSONObject rankMapJson = new JSONObject(map);
		JSONObject resultMapJson = new JSONObject(resultMap);

		model.addAttribute("rankMapJson", rankMapJson);
		model.addAttribute("category_type", category_type);
		model.addAttribute("resultMapJson", resultMapJson);
		model.addAttribute("resume_content", resume_content);

		for (int i = 0; i < list.size(); i++) {

			category.setCategory_word(list.get(i));

			int search = dao.selectCategoryCnt(category);

			if (search > 0) {

				dao.updateCategory(category);

			} else {

				dao.insertCategory(category);

			}

		}

		return "resume/resultPage";
	}

}
