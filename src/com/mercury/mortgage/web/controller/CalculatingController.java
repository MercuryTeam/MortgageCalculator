package com.mercury.mortgage.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CalculatingController {
	@RequestMapping(value="/calculator.html", method = RequestMethod.GET)
	public String calculator(ModelMap model) {
		return "content/calculator";
	}
	
	@RequestMapping(value="/calculating.html", method = RequestMethod.POST)
	@ResponseBody
	public String calculating(HttpServletRequest request) {	
		String principal = request.getParameter("principal");
		String loadTerm = request.getParameter("loadTerm");
		String zipCode = request.getParameter("zipCode");
		return principal + " " + loadTerm + " " + zipCode;
	}
}
