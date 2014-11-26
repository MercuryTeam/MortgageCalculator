package com.mercury.mortgage.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mercury.mortgage.service.CalculatingService;

@Controller
public class CalculatingController {
	@Autowired
	private CalculatingService cs;
	

	@RequestMapping(value="/calculator.html", method = RequestMethod.GET)
	public String calculator(ModelMap model) {
		return "content/calculator";
	}
	
	@RequestMapping(value="/calculating.html", method = RequestMethod.POST)
	@ResponseBody
	public String calculating(HttpServletRequest request) {
		double principal = Double.parseDouble(request.getParameter("principal"));
		int term = Integer.parseInt(request.getParameter("loadTerm"));
		String zipCode = request.getParameter("zipCode");
		return cs.getCalculatingResult(principal, term, zipCode);
	}
}
