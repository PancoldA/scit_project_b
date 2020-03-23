package global.sesoc.wareware.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import global.sesoc.wareware.vo.User;

public interface UserMapper {
	
	public int emailchk(String user_email);

    public void join_insert(@Param("user_email") String user_email, @Param("user_password") String user_password, @Param("user_name") String user_name, @Param("authorization") int authorization, @Param("helper") String helper);

    public void snsjoin_insert(@Param("user_email") String user_email, @Param("user_name") String user_name, @Param("user_password") String user_password, @Param("authorization") int authorization, @Param("sns_key") String sns_key, @Param("sns_type") String sns_type);

    public int snschk(String user_email);

    public String snstype(String user_email);

    public int keychk(@Param("user_email") String user_email, @Param("key") String key);

    public void auth_ok(String user_email);

    public int login(@Param("user_email") String user_email, @Param("user_password") String user_password);

    public int gradechk(String user_email);

    public String gethelper(String user_email);

    public void upkey(@Param("user_email") String user_email, @Param("key") String key);

    public void auth_null(String user_email);

    public void pw_modify(@Param("user_password") String user_password, @Param("helper") String helper, @Param("user_email") String user_email);

    public String getname(String user_email);

    public List<User> user_info(String user_email);

    public void name_modify(@Param("user_email") String user_email, @Param("user_name") String user_name);

    public String get_userid(String user_email);
    
	public int namechk(String user_name);
}
