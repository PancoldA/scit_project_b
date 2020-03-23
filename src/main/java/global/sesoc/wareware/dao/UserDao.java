package global.sesoc.wareware.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import global.sesoc.wareware.vo.User;

@Repository
public class UserDao {
	
	@Autowired
	SqlSession session;

	    public int emailchk(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.emailchk(user_email);
	    }

	    public int keychk(@Param("user_email") String user_email, @Param("key") String key) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.keychk(user_email, key);
	    }

	 
	    public void auth_ok(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.auth_ok(user_email);

	    }

	 
	    public int login(@Param("user_email") String user_email, @Param("user_password") String user_password) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.login(user_email, user_password);
	    }


	   
	    public void snsjoin_insert(@Param("user_email") String user_email, @Param("user_name") String user_name, @Param("user_password") String user_password, @Param("authorization") int authorization, @Param("sns_key") String sns_key, @Param("sns_type") String sns_type) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.snsjoin_insert(user_email, user_name, user_password, authorization, sns_key, sns_type);
	    }

	   
	    public String gethelper(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.gethelper(user_email);
	    }


	    public int snschk(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.snschk(user_email);
	    }

	
	    public String snstype(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.snstype(user_email);
	    }

	    
	    public int gradechk(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.gradechk(user_email);
	    }

	    
	    public void upkey(@Param("user_email") String user_email, @Param("key") String key) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.upkey(user_email, key);

	    }

	    
	    public void auth_null(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.auth_null(user_email);
	    }

	   
	    public void pw_modify(@Param("user_password") String user_password, @Param("helper") String helper, @Param("user_email") String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.pw_modify(user_password, helper, user_email);

	    }

	    
	    public String getname(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.getname(user_email);
	    }

	    
	    public void join_insert(@Param("user_email") String user_email, @Param("user_password") String user_password, @Param("user_name") String user_name, @Param("authorization") int authorization, @Param("helper") String helper) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.join_insert(user_email, user_password, user_name, authorization, helper);
	    }

	    
	    public List<User> user_info(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        return mapper.user_info(user_email);
	    }

	    
	    public void name_modify(@Param("user_email") String user_email, @Param("user_name") String user_name) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);
	        mapper.name_modify(user_email, user_name);
	    }

	    
	    public String get_userid(String user_email) {
	    	UserMapper mapper = session.getMapper(UserMapper.class);

	        return mapper.get_userid(user_email);
	    }

		
		public int namechk(String user_name) {
			UserMapper mapper = session.getMapper(UserMapper.class);
			return mapper.namechk(user_name);
		}
}
