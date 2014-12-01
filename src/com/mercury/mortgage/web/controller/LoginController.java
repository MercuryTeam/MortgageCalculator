package com.mercury.mortgage.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	@RequestMapping(value="/security/login.html", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "security/login";
	}
	
}
