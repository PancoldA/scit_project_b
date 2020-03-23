package global.sesoc.wareware.vo;

import lombok.Data;

@Data
public class User {
	private int user_id; //유저 pk
	private String authorization_id; //권한
	private String user_email; //이메일
	private String user_password; //비밀번호
	private String user_name; //이름
	private String user_create_date; //가입 날짜
	private String user_modify_date; //수정 날짜
	private String user_emailauthkey; //이메일 인증키  
	private String sns_key; // snskey
	private String sns_type; //snstype  
	private String salt; //패스워드 암호화를 돕는 컬럼


}
