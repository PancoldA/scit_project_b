package global.sesoc.wareware.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import global.sesoc.wareware.dao.UserDAO;
import global.sesoc.wareware.vo.User;

@Controller
public class UserController {

	@Autowired
	UserDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@GetMapping("/login")
	public String login() {
		logger.info("UserController's GET login Method");
		return "user/login";
	}

	@PostMapping("login")
	public String login(User user, Model model) {
		logger.info("UserController's POST login Method");
		logger.info("User : " + user.toString());

		int result = dao.selectOne(user);

		if (result > 0)
			return "redirect:/";
		else {
			model.addAttribute("fail", "Login Failed\nTry Again");
			return "user/login";
		}
	}

}
