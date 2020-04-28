package global.sesoc.wareware.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.wareware.mappers.PostingMapper;
import global.sesoc.wareware.vo.Posting;

@Repository
public class PostingDAO {

	@Autowired private PostingMapper mapper;
	
	public List<Posting> postingList(String experience, String education, String[] locations) {
		
		return mapper.selectAll(experience, education, locations);
	}
}
