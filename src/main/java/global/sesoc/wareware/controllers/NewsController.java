package global.sesoc.wareware.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.twitter.penguin.korean.TwitterKoreanProcessorJava;
import com.twitter.penguin.korean.tokenizer.KoreanTokenizer;

import global.sesoc.wareware.dao.NewsDAO;
import global.sesoc.wareware.vo.News;
import scala.collection.Seq;

@Controller
public class NewsController {
	
	@Autowired
	NewsDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	@GetMapping(value = "/news_sentiment")
	public String news_sentiment() {
		
		return "news/news_sentiment";
	}
		
	@ResponseBody
	@GetMapping(value = "getDate")
	public List<News> getDate(@RequestParam(value = "newsdate", defaultValue = "20200419") String newsdate){
		newsdate = newsdate.replaceAll("-", "");
		List<News> dateList = dao.getDate(newsdate);
		System.out.println(dateList);
		return dateList;
	}
	
	@ResponseBody
	@GetMapping(value = "getPopular")
	public List<News> getList(@RequestParam(value = "popular", defaultValue = "society") String popular){
		List<News> popularList = dao.getPopular(popular);
		System.out.println(popularList);
		return popularList;
	}
	
	
	@ResponseBody
	@GetMapping(value = "searchFromWord")
	public List<News> searchNews(@RequestParam(value = "searchWord", defaultValue = "코로나") String searchWord){
		List<News> searchList = dao.searchFromWord(searchWord);
		System.out.println(searchList);
		return searchList;
	}
	
	@ResponseBody
	@PostMapping(value = "wordcloud")
	public List<Map<String,Object>> wordcloud(@RequestParam(value = "result", defaultValue = "") String result){
		CharSequence normalized=result;
		normalized=TwitterKoreanProcessorJava.normalize(result);
		Seq<KoreanTokenizer.KoreanToken> tokens=TwitterKoreanProcessorJava.tokenize(normalized);
		tokens=TwitterKoreanProcessorJava.stem(tokens);
		List<String> javaParsed = TwitterKoreanProcessorJava.tokensToJavaStringList(tokens);
		Set<String> wordSet = new HashSet<String>();
        Map<String,Integer> wordCnt=new HashMap<String,Integer>();
       
        
        for(String s:javaParsed){
            //일반적으로 많이 등장하는 단어 : 단어 리스트에 불포함
                if(s.equals("으로")||s.equals("에서")||s.equals("이다")||s.equals("있다")||s.equals("가다")||s.equals("하다")
                   ||s.equals("보이다")||s.equals("같다")||s.equals("따르다")||s.equals("되다")||s.equals("처리")||s.equals("처리")
                   ||s.equals("19")||s.equals("1년")||s.equals("돼다")||s.equals("이후")||s.equals("연합뉴스")||s.equals("에는")
                   ||s.equals("두기")||s.equals("부터")||s.equals("하고")||s.equals("당사자")||s.equals("에게만")
                   ||s.equals("내다")||s.equals("위해")||s.equals("또한")
                	) continue;  
            
            //단어 길이가 1인 조사들 : 단어 리스트에 불포함
                if(s.length()>1){
                    if(wordSet.contains(s)){
                        wordCnt.put(s,1+wordCnt.get(s));
                    }else if(wordSet.isEmpty()){
                        wordCnt.put(s,1);
                    }else{
                        wordCnt.put(s,1);
                    }
                    wordSet.add(s);
                }
//                System.out.println(s);
        }
      //Json 형태로 만들기
        //최종 담을 리스트 변수
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        for(String temp:wordSet){
            if(wordCnt.get(temp)<2)    continue;
            else{
                Map<String,Object> map=new LinkedHashMap<String,Object>();
                map.put("text",temp);
                map.put("size",wordCnt.get(temp));
                System.out.println(map);
                list.add(map);
            }
        }
        return list;
	}
}
