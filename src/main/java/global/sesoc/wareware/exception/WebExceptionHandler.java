package global.sesoc.wareware.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


@ControllerAdvice
public class WebExceptionHandler {

	private static final Logger logger = LoggerFactory.getLogger(WebExceptionHandler.class);
	
	// 모든 종류의 오류를 처리
	@ExceptionHandler(Exception.class)
	public String errorHandler(Exception e, Model model) {
		
		logger.info("WebExceptionHandler's errorHandler Method");
		
		model.addAttribute("error", e.getMessage());
		
		return "errorPage";
		
	}
	
}
