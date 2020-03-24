package global.sesoc.wareware;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@GetMapping(value = "/")
	public String index01() {
		logger.info("HomeController's index Method");
		return "index";
	}
	
	@GetMapping(value = "/index")
	public String index02() {
		logger.info("HomeController's index Method");
		return "index";
	}
	
}
