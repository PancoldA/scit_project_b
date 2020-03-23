package global.sesoc.wareware.controller;

import java.io.IOException;

import java.util.Collections;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import global.sesoc.wareware.dao.MailSendService;
import global.sesoc.wareware.dao.UserDao;
import global.sesoc.wareware.model.SHA256Util;
import global.sesoc.wareware.model.SessionListener;
import global.sesoc.wareware.model.TempKey;

@Controller
public class UserController {
	
	@Autowired UserDao dao;
	
	@Inject MailSendService mailsender;
	
	private static final HttpTransport transport = new NetHttpTransport();
    private static final JsonFactory jsonFactory = new JacksonFactory();
	
 // 로그인 창
    @RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
    public String login() {
        return "user/login";
    }

    //로그인 체크 로직
    @RequestMapping(value = "login_chk", method = {RequestMethod.POST})
    @ResponseBody
    public String login_chk(@Param("user_email") String user_email, @Param("user_password") String user_password, HttpServletRequest request, Model model) {
        if (dao.emailchk(user_email) == 1) { //해당 이메일이 존재 하는지 확인
            if (dao.snschk(user_email) >= 1) { //sns회원인지  판별 (아닐경우)
                return dao.snstype(user_email);  //snstype이 무엇인지 확인함 sns회원이므로 일반 로그인 실패 처리
            } else {
                String memberhelper = dao.gethelper(user_email); // 멤버의 helper 가져오기
                String inputpassword = user_password;  //입력된 암호 가져오기
                String newpassword = SHA256Util.getEncrypt(inputpassword, memberhelper); // 가져온 helper을 이용하여 sha 암호 get
                if (dao.login(user_email, newpassword) == 1) {  //로그인 검증
                    HttpSession session = request.getSession(true);     //로그인 세션 추가
                    if (SessionListener.getInstance().isUsing(user_email)) {  // 로그인 중복시
                        if (SessionListener.getInstance().chk_table(session, user_email)) {
                            SessionListener.getInstance().removeSession(user_email);
                            session.setAttribute("user", user_email); // 세션추가
                            session.setAttribute("name", dao.getname(user_email)); //닉네임 겟
                            session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
                            session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
                            SessionListener.getInstance().setSession(session, user_email);//로그인을 완료한 사용자의 아이디를 세션에 저장
                            return "1";
                        }
                    } else { //중복로그인이 아닐시  로그인처리
                        session.setAttribute("user", user_email); // 세션추가
                        session.setAttribute("name", dao.getname(user_email)); //닉네임 겟
                        session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
                        session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
                        SessionListener.getInstance().setSession(session, user_email);//로그인을 완료한 사용자의 아이디를 세션에 저장
                        return "1"; //인증회원 로그인
                    }
                } else if (dao.login(user_email, newpassword) == 0) {
                    return "2"; // 로그인 실패
                }
            }
        } else {
            return "2";
        }
        return "2";
    }

    //구글 sns
    @RequestMapping(value = "google", method = {RequestMethod.POST})
    @ResponseBody
    public String google(@RequestParam("idtoken") String idtoken, HttpServletRequest request) throws Exception {

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
                .setAudience(Collections.singletonList("589581046105-skr2iee57c8j3o02lsl3g284ts0g0ks9.apps.googleusercontent.com"))
                .build();

        GoogleIdToken idToken = verifier.verify(idtoken);
        if (idToken != null) {
            Payload payload = idToken.getPayload();

            String user_email = payload.getEmail();
            String user_name = (String) payload.get("name");

            HttpSession session = request.getSession();
            
            //이메일이 중복일경우 로그인
            if ("google".equals(dao.snstype(user_email))) {
                session.setAttribute("user", user_email);
                session.setAttribute("name", dao.getname(user_email));
                session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
                session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
                SessionListener.getInstance().setSession(session, user_email);
                return "1";
            }
            //아닐경우 가입 후 자동 로그인
            else if (dao.emailchk(user_email) == 0) {
                int authorization = 4; // sns 회원은 메일인증이 필요없어서 인증등급부여

                TempKey tempkey = new TempKey();
                String key = tempkey.getKey(20, false);//sns회원이라서 랜덤 비밀번호생성

                String helper = SHA256Util.generateHelper();
                String user_password = SHA256Util.getEncrypt(key, helper);

                String sns_key = "test";
                String sns_type = "google";

                //sns 회원가입 (인증키가 없고 비밀번호는 랜덤비밀번호를 사용 (사실상 일반회원로그인이 안되게 막은것))
                
                if(1==(dao.namechk(user_name))){
                	int i = 0;
                	while(true) {
                	user_name = user_name + i;
                	i++;
                	if(0==(dao.namechk(user_name))) {
                		break;
                	}
                	}
                }
                
                dao.snsjoin_insert(user_email, user_name, user_password, authorization, sns_key, sns_type);
                session.setAttribute("user", user_email);
                session.setAttribute("name", dao.getname(user_email));
                session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
                session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
                SessionListener.getInstance().setSession(session, user_email);
                return "3";
            } else {
                return "2";
            }
        } else {
            System.out.println("토큰이없음");
        }
        return "4";
    }

    //카카오
    @RequestMapping(value = "kakao", method = {RequestMethod.POST})
    @ResponseBody
    public String kakao(@RequestParam("user_email") String user_email, @RequestParam("user_name") String user_name, HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();

//이메일이 중복일경우 로그인
        if ("kakao".equals(dao.snstype(user_email))) {
            session.setAttribute("user", user_email);
            session.setAttribute("name", dao.getname(user_email));
            session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
            session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
            SessionListener.getInstance().setSession(session, user_email);
            return "1";
        }

        //아닐경우 가입 후 자동 로그인
        else if (dao.emailchk(user_email) == 0) {
            int authorization = 4; // sns 회원은 메일인증이 필요없어서 인증등급부여

            TempKey tempkey = new TempKey();
            String key = tempkey.getKey(20, false);//sns회원이라서 랜덤 비밀번호생성

            String helper = SHA256Util.generateHelper();
            String user_password = SHA256Util.getEncrypt(key, helper);


            String sns_key = "test";
            String sns_type = "kakao";

            if(1==(dao.namechk(user_name))){
            	int i = 0;
            	while(true) {
            	user_name = user_name + i;
            	i++;
            	if(0==(dao.namechk(user_name))) {
            		break;
            	}
            	}
            }
            //sns 회원가입 (인증키가 없고 비밀번호는 랜덤비밀번호를 사용 (사실상 일반회원로그인이 안되게 막은것))
            dao.snsjoin_insert(user_email, user_name, user_password, authorization, sns_key, sns_type);
            session.setAttribute("user", user_email);
            session.setAttribute("name", dao.getname(user_email));
            session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
            session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
            SessionListener.getInstance().setSession(session, user_email);

            return "3";
        } else {
            return "2";
        }

    }

    //네이버
    @RequestMapping(value = "naver", method = {RequestMethod.POST})
    @ResponseBody
    public String naver(@RequestParam("user_email") String user_email, @RequestParam("user_name") String user_name, HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();

        //이메일이 중복일경우 로그인
        if ("naver".equals(dao.snstype(user_email))) {
            session.setAttribute("user", user_email);
            session.setAttribute("name", dao.getname(user_email));
            session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
            session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
            SessionListener.getInstance().setSession(session, user_email);
            return "1";
        }
        //아닐경우 가입 후 자동 로그인
        else if (dao.emailchk(user_email) == 0) {
            int authorization = 4; // sns 회원은 메일인증이 필요없어서 인증등급부여
            TempKey tempkey = new TempKey();
            String key = tempkey.getKey(20, false);//sns회원이라서 랜덤 비밀번호생성

            String helper = SHA256Util.generateHelper();
            String user_password = SHA256Util.getEncrypt(key, helper);

            String sns_key = "test";
            String sns_type = "naver";
            
            if(1==(dao.namechk(user_name))){
            	int i = 0;
            	while(true) {
            	user_name = user_name + i;
            	i++;
            	if(0==(dao.namechk(user_name))) {
            		break;
            	}
            	}
            }

            //sns 회원가입 (인증키가 없고 비밀번호는 랜덤비밀번호를 사용 (사실상 일반회원로그인이 안되게 막은것))
            dao.snsjoin_insert(user_email, user_name, user_password, authorization, sns_key, sns_type);
            session.setAttribute("user", user_email);
            session.setAttribute("name", dao.getname(user_email));
            session.setAttribute("user_id", dao.get_userid(user_email)); // user_id 겟
            session.setAttribute("grade", Integer.toString(dao.gradechk(user_email))); // 유저 등급 겟
            SessionListener.getInstance().setSession(session, user_email);
            return "3";
        } else {
            return "2";
        }

    }

    @RequestMapping(value = "callback", method = {RequestMethod.GET, RequestMethod.POST})
    public String callback() throws Exception {

        return "user/callback";
    }


    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        if (SessionListener.getInstance().getUserID(session) == null) {
            session.invalidate();
        }
        SessionListener.getInstance().removeSession(SessionListener.getInstance().getUserID(session));
        return "redirect:/";
    }


    // 가입
    @RequestMapping(value = "signup", method = {RequestMethod.GET, RequestMethod.POST})
    public String signup() {
        return "user/signup";
    }


    // 비밀번호 찾기
    @RequestMapping(value = "pwfind", method = {RequestMethod.GET, RequestMethod.POST})
    public String pwfind() {
        return "user/pwfind";
    }


    // 비밀번호 찾기
    @RequestMapping(value = "pwfind_go", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String pwfind_go(@Param("user_email") String user_email, HttpServletRequest request) {
        TempKey tempkey = new TempKey();
        String key = tempkey.getKey(10, false); //임시비밀번호 10사이즈 생성
        String helper = SHA256Util.generateHelper();
        String newpassword = SHA256Util.getEncrypt(key, helper); //임시비밀번호 암호화 처리

        if (dao.snstype(user_email) == "" || dao.snstype(user_email) == null) {
            dao.pw_modify(newpassword, helper, user_email);  //비밀번호 업데이트
            mailsender.tempkey_submit(user_email, key, request);  // 수정된 비밀번호를 전송
            return "1";
        }
        return "2";
    }


    //이메일 인증코드 발송
    @RequestMapping(value = "auth_submit", method = {RequestMethod.POST})
    @ResponseBody
    public String auth_submit(@Param("user_email") String user_email, HttpServletRequest request) throws IOException {

        TempKey tempkey = new TempKey();
        String key = tempkey.getKey(15, false); //랜덤으로 이루어진 인증키 15사이즈 생성
        System.out.println(key);
        HttpSession session = request.getSession();
        Object obj = session.getAttribute("authkey");

        //세션에 인증키 임시등록
        if (obj == null) {
            session.setAttribute("authkey", key);
            mailsender.mailSendWithUserKey(user_email, key, request);
            return "1";
        } else {
            session.removeAttribute("authkey");
            session.setAttribute("authkey", key);
            mailsender.mailSendWithUserKey(user_email, key, request);
            return "1";
        }
    }

    //이메일 인증코드 확인

    @RequestMapping(value = "auth_check", method = {RequestMethod.POST})
    @ResponseBody
    public String auth_check(@Param("auth_key") String auth_key, HttpServletRequest request) {

        HttpSession session = request.getSession();
        String emauth_key = (String) session.getAttribute("authkey");
        if (auth_key.equals(emauth_key)) {
            session.invalidate();
            return "1";
        }
        return "2";
    }

    //가입
    @RequestMapping(value = "signup_go", method = {RequestMethod.POST})
    @ResponseBody
    public String signup_go(@Param("user_email") String user_email, @Param("user_password") String user_password, @Param("user_name") String user_name, HttpServletRequest request) {

        String helper = SHA256Util.generateHelper();
        String newPassword = SHA256Util.getEncrypt(user_password, helper);
        int authorization = 4; //인증회원
        dao.join_insert(user_email, newPassword, user_name, authorization, helper);
        return "1";
    }


    @RequestMapping(value = "auth", method = {RequestMethod.GET, RequestMethod.POST})
    public String auth() {
        return "user/auth";
    }


    @RequestMapping(value = "emailchk", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String emailchk(@Param("user_email") String user_email) {
        return Integer.toString(dao.emailchk(user_email));
    }

    @RequestMapping(value = "namechk", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String namechk(@Param("user_name") String user_name) {
        return Integer.toString(dao.namechk(user_name));
    }

//    //로그인 인터셉터
//    @RequestMapping(value = "logininterceptor", method = {RequestMethod.GET, RequestMethod.POST})
//    public String interceptor(Model model) {
//    	
//    	Map<String, List<CompanyListVO>> map1 = new HashMap<>();
//        map1.put("follow 많은 기업", companyService.getManyFollowOrdersList());
//        map1.put("면접리뷰 많은 기업", companyService.getManyInterviewReviewOrdersList());
//        
//        Map<Integer, Map<String, List<CompanyListVO>>> map2 = new HashMap<>();
//        List<Map<String, List<CompanyListVO>>> list = new ArrayList<>();
//        String[] categoryArr = companyService.getCategoryArr();
//        for(int i = 0; i < categoryArr.length/2; i++) {
//        	list.add(new HashMap<>());
//        	for(int j = 2*i; j < categoryArr.length; j++) {
//            	if(list.get(i).size()==2) continue;
//        		list.get(i).put(categoryArr[j], companyService.getMostCtOrdersList(j));
//            	if(j%2 == 1) map2.put(i, list.get(i)); 
//            }
//        }
//
//        model.addAttribute("map1", map1);
//        model.addAttribute("map2", map2);
//
//        String ltr = "";
//        ltr += "<script>";
//        ltr += "$(window).on('load',function(){";
//        ltr += "Swal.fire({";
//        ltr += "title: '로그인이 필요합니다.',";
//        ltr += "text:'로그인 하시겠습니까?',";
//        ltr += "cancelButtonText: '취소',";
//        ltr += "type: 'warning',";
//        ltr += "showCancelButton: true,";
//        ltr += "confirmButtonColor: '#3085d6',";
//        ltr += "cancelButtonColor: '#d33',";
//        ltr += "confirmButtonText: '로그인'";
//        ltr += "}).then((result) => {";
//        ltr += "if (result.value) {";
//        ltr += "$('#loginModal').modal('show');";
//        ltr += "}";
//        ltr += "else {";
//        ltr += "history.back();";
//        ltr += "}";
//        ltr += "});";
//        ltr += "});";
//        ltr += "</script>";
//
//       model.addAttribute("ltr", ltr);
//       
//       return "index";
//    }

//    @RequestMapping(value = "myPage_menu", method = {RequestMethod.GET, RequestMethod.POST})
//    public String myPage_menu(HttpSession session, Model model) {
//
//        String user_email = (String) session.getAttribute("user");
//
//        model.addAttribute("Uinfo_list", dao.user_info(user_email));
//
//        return "mypage/myPage_Menu";
//    }


//    @RequestMapping(value = "/user_info", method = {RequestMethod.GET, RequestMethod.POST})
//    public String user_info(HttpSession session, Model model) {
//
//        String user_email = (String) session.getAttribute("user");
//
//        model.addAttribute("Uinfo_list", dao.user_info(user_email));
//        model.addAttribute("snschk", Integer.toString(dao.snschk(user_email)));
//
//        return "mypage/user_info";
//    }


//    @RequestMapping(value = "name_modify", method = {RequestMethod.POST})
//    @ResponseBody
//    public String user_info_modify(@Param("user_email") String user_email, @Param("user_password") String user_password, @Param("user_name") String user_name, HttpSession session) {
//
//        dao.name_modify(user_email, user_name);
//
//        session.removeAttribute("name");
//        session.setAttribute("name", dao.getname(user_email));
//
//        return "1";
//    }
//
//    @RequestMapping(value = "pw_modify", method = {RequestMethod.POST})
//    @ResponseBody
//    public String pw_modify(@Param("user_email") String user_email, @Param("user_password") String user_password, HttpSession session) {
//
//        String helper = SHA256Util.generateHelper();
//        String newPassword = SHA256Util.getEncrypt(user_password, helper);
//
//        dao.pw_modify(newPassword, helper, user_email);
//
//        SessionListener.getInstance().removeSession(SessionListener.getInstance().getUserID(session));
//
//
//        return "1";
//    }


//    //킥 된 사용자
//    @RequestMapping(value = "gradeceptor", method = {RequestMethod.GET, RequestMethod.POST})
//    public String gradeceptor(Model model) {
//    	 
//    	Map<String, List<CompanyListVO>> map1 = new HashMap<>();
//        map1.put("follow 많은 기업", companyService.getManyFollowOrdersList());
//        map1.put("면접리뷰 많은 기업", companyService.getManyInterviewReviewOrdersList());
//        
//        Map<Integer, Map<String, List<CompanyListVO>>> map2 = new HashMap<>();
//        List<Map<String, List<CompanyListVO>>> list = new ArrayList<>();
//        String[] categoryArr = companyService.getCategoryArr();
//        for(int i = 0; i < categoryArr.length/2; i++) {
//        	list.add(new HashMap<>());
//        	for(int j = 2*i; j < categoryArr.length; j++) {
//            	if(list.get(i).size()==2) continue;
//        		list.get(i).put(categoryArr[j], companyService.getMostCtOrdersList(j));
//            	if(j%2 == 1) map2.put(i, list.get(i)); 
//            }
//        }
//
//        model.addAttribute("map1", map1);
//        model.addAttribute("map2", map2);
//
//        String ktr = "";
//        ktr += "<script>";
//        ktr += "Swal.fire({";
//        ktr += "type: 'warning',";
//        ktr += "html: '회원님은 계정 제한 상태입니다.<br> 관리자 메일로 문의해주십시오.'";
//        ktr += "})";
//        ktr += "</script>";
//
//        model.addAttribute("ktr", ktr);
//
//        return "index";
//    }
}
