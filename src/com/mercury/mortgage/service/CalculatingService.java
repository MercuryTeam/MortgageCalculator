package com.mercury.mortgage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.mortgage.persistence.model.OneMonthSchedule;
import com.mercury.mortgage.persistence.model.Rate;
import com.mercury.mortgage.persistence.model.Schedule;

@Service
@Transactional(readOnly = true)
public class CalculatingService {
	@Autowired
	@Qualifier("rateDao")
	private HibernateDao<Rate, Integer> hd;
		
	public HibernateDao<Rate, Integer> getHd() {
		return hd;
	}

	public void setHd(HibernateDao<Rate, Integer> hd) {
		this.hd = hd;
	}

	public Schedule getCalculatingResult(double principal, String term, String zipCode) {
		Schedule schedule = null;
		
		if ("15".equals(term) || "20".equals(term) || "30".equals(term)) {
			schedule = fixedCalculating(principal, term, zipCode);
		} else {
			schedule = armCalculating(principal, term, zipCode);
		}
		
		return schedule;
		/*
		String result = schedule.getPrincipal() + ", " + schedule.getTotalInterest() + "<br />";
		for (OneMonthSchedule om:schedule.getList()) {
			result += om.getMonth() + ", " + om.getPayment() + ", " + om.getPayPrincipal() + ", " 
					+ om.getInterest() + ", " + om.getRemainPrincipal() + "<br />";
		}
		
		return result;
		*/
	}
	
	/* Calculating fixed rate mortgage schedule */
	private Schedule fixedCalculating(double principal, int numOfMonths, double rate, 
					int startMonth, int endMonth, boolean willEnd)  {
		Schedule schedule = new Schedule();
		schedule.setPrincipal(principal);
		List<OneMonthSchedule> list = new ArrayList<OneMonthSchedule>();		
		
		double interest;
		double totalInterest = 0;
		double payPrincipal;
		double monthlyRate = rate / 12;
		double monthlyPayment = principal * (monthlyRate / (1 - Math.pow(1 + monthlyRate, -numOfMonths)));
		if (!willEnd) {
			endMonth++;
		}
		for (int i = startMonth; i < endMonth; i++) {
			interest = principal * monthlyRate;
			payPrincipal = monthlyPayment - interest;
			principal = principal - payPrincipal;
			OneMonthSchedule oms = new OneMonthSchedule(i, monthlyPayment, payPrincipal, interest, principal);
			list.add(oms);
			totalInterest += interest;
		}
		
		if (willEnd) {
			interest = principal * monthlyRate;
			monthlyPayment = principal + interest;
			OneMonthSchedule oms = new OneMonthSchedule(endMonth, monthlyPayment, principal, interest, 0);
			list.add(oms);
			totalInterest += interest;
		}
		schedule.setList(list);
		schedule.setTotalInterest(totalInterest);
		
		return schedule;
	}
	
	private Schedule fixedCalculating(double principal, String term, String zipCode) {
		int numOfMonths = Integer.parseInt(term) * 12;
		double rate = getInterestRate(term, zipCode);
		return fixedCalculating(principal, numOfMonths, rate, 1, numOfMonths, true);
	}
	
	/* Calculating adjustable rate mortgage schedule */
	private Schedule armCalculating(double principal, String term, String zipCode) {
		int numOfMonths = 30 * 12;
		int initialFixed = Integer.parseInt(term) * 12;
		double rate = getInterestRate(term, zipCode);
		double totalInterest = 0;
		Schedule scheduleResult = new Schedule();
		scheduleResult.setPrincipal(principal);
		
		//Initial fixed schedule
		Schedule schedule = fixedCalculating(principal, numOfMonths, rate, 1, initialFixed, false);		
		rate = rate - 0.025 / 100;
		List<OneMonthSchedule> list = schedule.getList();
		principal = list.get(list.size() - 1).getRemainPrincipal();
		numOfMonths = numOfMonths - initialFixed;
		totalInterest += schedule.getTotalInterest();
		scheduleResult.setList(list);
		
		//remain schedule
		for (int i = initialFixed + 1; i < 30 * 12 - 11; i += 12) {			
			schedule = fixedCalculating(principal, numOfMonths, rate, i, i + 11, false);
			rate = rate - 0.025 / 100;
			list = schedule.getList();
			principal = list.get(list.size() - 1).getRemainPrincipal();
			numOfMonths = numOfMonths - 12;
			totalInterest += schedule.getTotalInterest();
			scheduleResult.getList().addAll(list);
		}
		
		schedule = fixedCalculating(principal, numOfMonths, rate, 30 * 12 - 11, 30 * 12, true);		
		list = schedule.getList();
		totalInterest += schedule.getTotalInterest();
		scheduleResult.getList().addAll(list);
		scheduleResult.setTotalInterest(totalInterest);
		
		return scheduleResult;
	}
	
	
	private double getInterestRate(String term, String zipCode) {
		Map<String, Double> map = new HashMap<String, Double>();
		Rate interestRate = hd.findBy("zipCode", zipCode);
		map.put("15", interestRate.getRate15());
		map.put("20", interestRate.getRate20());
		map.put("30", interestRate.getRate30());
		map.put("5", interestRate.getArm5());
		map.put("7", interestRate.getArm7());
		map.put("10", interestRate.getArm10());
		return map.get(term) / 100;
	}
}
