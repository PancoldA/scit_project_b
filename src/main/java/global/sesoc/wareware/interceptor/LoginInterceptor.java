package global.sesoc.wareware.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("LoginInterceptor's preHandle Method");

		// 세션의 로그인 정보
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("sessionId");

		// loginId == null : 로그아웃 상태
		if (loginId == null) {
			// 로그인 화면으로 이동

			String contextPath = request.getContextPath();

			response.sendRedirect(contextPath + "/login"); // 리다이렉트 후 화면에 대한 정보

			return false;
		}

		return true;

	}
}
