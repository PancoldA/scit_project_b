package global.sesoc.wareware.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import global.sesoc.wareware.mappers.NewsMapper;
import global.sesoc.wareware.vo.News;

@Repository
public class NewsDAO {

	@Autowired
	SqlSession session;

	public List<News> getDate(String newsdate) {
		NewsMapper mapper = session.getMapper(NewsMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("newsdate", newsdate);
		
		return mapper.getDate(map);
	}
	
	public List<News> getPopular(String popular) {
		NewsMapper mapper = session.getMapper(NewsMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("popular", popular);
		
		return mapper.getPopular(map);
	}
	
	public List<News> searchFromWord(String searchWord){
		NewsMapper mapper = session.getMapper(NewsMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchWord", searchWord);

		return mapper.searchFromWord(map);
	}
}
