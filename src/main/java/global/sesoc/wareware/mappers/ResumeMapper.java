package global.sesoc.wareware.mappers;

import java.util.List;

import global.sesoc.wareware.vo.Category;
import global.sesoc.wareware.vo.Resume;

public interface ResumeMapper {

	// 이력서 저장
	public int insertResume(Resume resume);

	// 카테고리 리스트에 해당하는 단어 리스트 가져오기
	public List<String> getList(String category_list);

	// 카테고리 단어 언급 횟수 업데이트
	public void updateCategory(Category category);

	// 카테고리 안에 일치하는 단어가 있는지 조사
	public int selectCategoryCnt(Category category);

	// 카테고리 추가
	public void insertCategory(Category category);

}
