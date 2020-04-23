package global.sesoc.wareware.controllers;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;

import global.sesoc.wareware.dao.UserDAO;
import global.sesoc.wareware.service.NaverLoginBO;
import global.sesoc.wareware.vo.User;

@Controller
public class UserController {

	@Autowired
	UserDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	/* NaverLoginBO */

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	// 로그인 화면 요청 메소드
	@GetMapping("/login")
	public String login(Model model, HttpSession session) {

		logger.info("UserController's GET login Method");

		// 네이버아이디로 인증 URL을 생성
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		logger.info("naverAuthUrl :" + naverAuthUrl);

		// 네이버아이디로 인증 URL을 담아서 보냄
		model.addAttribute("naverAuthUrl", naverAuthUrl);
		return "user/login";
	}

	// 자체 로그인 요청 메소드 (외부 로그인 회원 제외)
	@PostMapping("/login")
	public String login(User user, Model model, HttpSession session) {
		logger.info("UserController's POST login Method");
		logger.info("User : " + user.toString());

		User selected = dao.selectOne(user);

		if (selected != null) { // 로그인 성공 시 메인으로

			String snstype = selected.getUser_sns_type();
			String username = selected.getUser_name();

			if (snstype == null || snstype == "") {

				if (username == null || username == "" || username.isEmpty()) {

					session.setAttribute("sessionId", selected.getUser_email());

				} else {

					session.setAttribute("sessionId", username);

				}

				logger.info(selected.toString());
				return "redirect:/";

			} else {

				switch (snstype) {

				case "naver":
					model.addAttribute("login_message", "네이버 아이디가 이미 존재합니다.\\n네이버로 로그인 해주세요.");
					break;

				case "kakao":
					model.addAttribute("login_message", "카카오 아이디가 이미 존재합니다.\\n카카오로 로그인 해주세요.");
					break;

				case "google":
					model.addAttribute("login_message", "구글 아이디가 이미 존재합니다.\\n구글로 로그인 해주세요.");
					break;

				default:

					break;
				}

				return "user/login";

			}

		} else {

			model.addAttribute("login_message", "로그인에 실패하였습니다.\\n다시 시도해주세요.");
			return "user/login";

		}

	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/auth/naver/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,
			RedirectAttributes rttr) throws IOException, ParseException {

		logger.info("UserController's GET/POST callback Method");

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터

		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449" ,"nickname":"shinn****" ,"age":"20-29"
		 * ,"gender":"M" ,"email":"sh@naver.com" ,"name":"\uc2e0\ubc94\ud638"}}
		 **/

		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// 3. 데이터 파싱

		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		String naver_email = (String) response_obj.get("email");
		String naver_name = (String) response_obj.get("name");

		// *. 가입한 이메일인지 확인
		User user = new User();
		user.setUser_email(naver_email);
		User select = dao.selectOne(user);

		if (select != null) {

			// 네이버로 DB가 존재할 경우
			if (select.getUser_sns_type() == "naver") {

				session.setAttribute("sessionId", select.getUser_name());
				return "redirect:/";

			}

			// 자체 회원 가입일 경우 회원 DB 통합
			else if (select.getUser_sns_type() == null || select.getUser_sns_type() == ""
					|| select.getUser_sns_type().isEmpty()) {

				String snsKey = (String) response_obj.get("id");

				select.setUser_sns_key(snsKey);
				select.setUser_sns_type("naver");

				int result = dao.updateUser(select);
				session.setAttribute("sessionId", naver_name);

				if (result > 0) {
					rttr.addFlashAttribute("naver_message", "기존 회원 정보가 네이버 아이디로 통합되었습니다.\\n앞으로는 네이버로만 로그인이 가능합니다.");
					return "redirect:/";
				} else {
					rttr.addFlashAttribute("naver_message",
							"기존의 회원 정보와 통합이 원활하게 이뤄지지 않았습니다.\\n기존 회원 정보를 삭제하거나 관리자에게 문의해주십시오.");
					return "redirect:/";
				}
			}

		} else { // 외부 로그인 회원가입

			String gender = (String) response_obj.get("gender");
			String snsKey = (String) response_obj.get("id");

			user.setUser_name(naver_name);
			user.setUser_gender(gender);
			user.setUser_sns_key(snsKey);
			user.setUser_sns_type("naver");

			dao.insertUser(user);

			session.setAttribute("sessionId", user.getUser_name());

			return "redirect:/";

		}

		session.setAttribute("sessionId", naver_name);
		return "redirect:/";

	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) throws IOException {
		logger.info("UserController's GET/POST logout Method");
		session.invalidate();
		return "redirect:/";
	}

	// 회원가입 화면 요청 메소드
	@GetMapping("/signup")
	public String signup() {
		logger.info("UserController's GET signup Method");
		return "user/signup";
	}

	// 이메일 중복 체크 메소드
	@ResponseBody
	@PostMapping("/emailCheck")
	public String emailCheck(User user) {
		logger.info("UserController's POST emailCheck Method");
		logger.info("email : " + user.getUser_email());

		User result = dao.selectOne(user);

		if (result != null)
			return "fail";
		else
			return "success";
	}

	@PostMapping("signup")
	public String signup(User user, HttpSession session) {

		int result = dao.insertUser(user);

		if (result > 0) {
			return "redirect:/";
		} else
			return "redirect:/user/signup";

	}

}
