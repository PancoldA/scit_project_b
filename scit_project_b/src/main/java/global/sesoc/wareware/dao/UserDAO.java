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

	// 로그인 : 아이디와 비밀번호 확인
	public int selectOne(User user) {
		
		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.selectOneCount(user);

	}

}
