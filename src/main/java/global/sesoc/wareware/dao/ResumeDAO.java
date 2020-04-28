package global.sesoc.wareware.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.wareware.mappers.ResumeMapper;
import global.sesoc.wareware.vo.Category;
import global.sesoc.wareware.vo.Resume;

@Repository
public class ResumeDAO {

	@Autowired
	SqlSession session;

	// 이력서 등록
	public int insertResume(Resume resume) {
		
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.insertResume(resume);
		
	}

	// 카테코리 리스트 가져오기
	public List<String> getList(String category_list) {

		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.getList(category_list);

	}

	// 단어 언급 횟수 업데이트
	public void updateCategory(Category category) {
		
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		mapper.updateCategory(category);
		
	}

	// 카테고리 리스트에 일치하는 단어가 있는지 조사
	public int selectCategoryCnt(Category category) {

		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.selectCategoryCnt(category);

	}

	// 카테고리 리스트 추가 (머신러닝!)
	public void insertCategory(Category category) {
		
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		mapper.insertCategory(category);
		
	}

	// 자소서 리스트 가져오기
	public List<Resume> resumeList(Resume resume) {

		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.resumeList(resume);

	}

	// 하나의 자소서 가져오기
	public Resume selectOne(int resume_no) {
		
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.selectOne(resume_no);
	
	}

	// 자소서 지우기
	public int deleteResume(int resume_no) {
		
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.deleteResume(resume_no);
		
	}

	// 자소서 수정
	public int updateResume(Resume resume) {

		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		return mapper.updateResume(resume);

	}
	
}
