package global.sesoc.wareware.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@GetMapping(value = "/")
	public String index01() {
		logger.info("HomeController's GET index Method");
		return "index";
	}
	
	@GetMapping(value = "/index")
	public String index02() {
		logger.info("HomeController's GET index Method");
		return "index";
	}
	
	//연락관련 템플릿
	@GetMapping(value = "/contact")
	public String contact() {
		logger.info("HomeController's GET index Method");
		return "temp/contact";
	}
	
	//여러가지 요소관련 템플릿
	@GetMapping(value = "/elements")
	public String elements() {
		logger.info("HomeController's GET index Method");
		return "temp/elements";
	}
	
	//문서관련 템플릿
	@GetMapping(value = "/generic")
	public String generic() {
		logger.info("HomeController's GET index Method");
		return "temp/generic";
	}
	
	//메인화면 관련 템플릿
	@GetMapping(value = "/gindex")
	public String gindex() {
		logger.info("HomeController's GET index Method");
		return "temp/Gindex";
	}
}
