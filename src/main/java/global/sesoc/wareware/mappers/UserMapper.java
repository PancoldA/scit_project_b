package global.sesoc.wareware.mappers;

import global.sesoc.wareware.vo.User;

public interface UserMapper {

	// 자체 로그인 : 아이디(email)와 비밀번호가 맞는지 확인
	public User selectOne(User user);

	// 회원 가입
	public int insertUser(User user);

	// 회원 정보 수정
	public int updateUser(User user);

}
