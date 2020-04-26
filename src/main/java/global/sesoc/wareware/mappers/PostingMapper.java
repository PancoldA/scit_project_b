package global.sesoc.wareware.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import global.sesoc.wareware.vo.Posting;

public interface PostingMapper {
	
	List<Posting> selectAll(@Param("experience") String experience, @Param("education") String education, @Param("locations") String[] locations);
}
