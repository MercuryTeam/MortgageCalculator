package com.mercury.mortgage.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CalculatingController {

	@RequestMapping(value="/content/calculator.html", method = RequestMethod.GET)
	public String calculator(ModelMap model) {
		return "content/calculator";
	}
	
	/*
	@RequestMapping(value="/calculating.html", method = RequestMethod.POST)
	@ResponseBody
	public String calculating(HttpServletRequest request) {
		double principal = Double.parseDouble(request.getParameter("principal"));
		String term = request.getParameter("loadTerm");
		String zipCode = request.getParameter("zipCode");
		return cs.getCalculatingResult(principal, term, zipCode);
	}
	*/
}
