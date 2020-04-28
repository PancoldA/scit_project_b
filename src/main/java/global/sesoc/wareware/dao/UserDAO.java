package global.sesoc.wareware.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.wareware.mappers.UserMapper;
import global.sesoc.wareware.vo.User;

@Repository
public class UserDAO {

	@Autowired
	SqlSession session;

	// 로그인 시 아이디와 비밀번호 확인
	// 회원가입 시 아이디 중복 체크
	public User selectOne(User user) {
		
		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.selectOne(user);

	}

	// 회원가입
	public int insertUser(User user) {
		
		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.insertUser(user);
		
	}

	// 회원 정보 수정
	public int updateUser(User user) {

		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.updateUser(user);
		
	}

}
