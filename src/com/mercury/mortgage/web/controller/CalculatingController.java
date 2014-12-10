package com.mercury.mortgage.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CalculatingController {

	@RequestMapping(value="/calculator.html", method = RequestMethod.GET)
	public ModelAndView calculator(ModelMap model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("content/calculator");
		// Get username
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		String authority = auth.getAuthorities().toString();
		mav.addObject("username", name);	
		mav.addObject("role", authority);
		// The parameter to indicate if activate success
		String isSuccess = request.getParameter("isSuccess");
		mav.addObject("isSuccess", isSuccess);
		return mav;

	}
	@RequestMapping(value="/FunctionCalculator.html", method = RequestMethod.GET)
	public ModelAndView mycal(ModelMap model) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("content/FunctionCalculator");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		String authority = auth.getAuthorities().toString();
	    mav.addObject("username", name);
	    mav.addObject("role", authority);
		return mav;

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
