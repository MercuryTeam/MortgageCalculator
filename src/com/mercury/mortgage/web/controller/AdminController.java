package com.mercury.mortgage.web.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class AdminController {

	@RequestMapping(value="/admin.html", method = RequestMethod.GET)
	public ModelAndView calculator() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("content/admin");
		// Get username
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		mav.addObject("username", name);
		return mav;
	}
}
