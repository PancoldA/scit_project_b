package global.sesoc.wareware.mappers;

import java.util.List;
import java.util.Map;
import global.sesoc.wareware.vo.News;

public interface NewsMapper {
	public List<News> getDate(Map<String, Object> map);
	public List<News> getPopular(Map<String, Object> map);
	public List<News> searchFromWord(Map<String, Object> map);
}
