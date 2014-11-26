package com.mercury.mortgage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.mortgage.persistence.dao.RateDao;
import com.mercury.mortgage.persistence.model.OneMonthSchedule;
import com.mercury.mortgage.persistence.model.Schedule;

@Service
@Transactional(readOnly = true)
public class CalculatingService {
	@Autowired
	private RateDao rd;
		
	public RateDao getRd() {
		return rd;
	}
	
	public void setRd(RateDao rd) {
		this.rd = rd;
	}
	
	public String getCalculatingResult(double principal, int term, String zipCode) {
		Schedule schedule = new Schedule();
		schedule.setPrincipal(principal);
		List<OneMonthSchedule> list = new ArrayList<OneMonthSchedule>();		
		
		double interest;
		double totalInterest = 0;
		double payPrincipal;
		int numOfMonths = term * 12;
		double rate = rd.getRateByZipCode(zipCode).getRate();
		double monthlyRate = rate / 12;
		double monthlyPayment = principal * (monthlyRate / (1 - Math.pow(1 + monthlyRate, -numOfMonths)));
		for (int i = 1; i < numOfMonths; i++) {
			interest = principal * monthlyRate;
			payPrincipal = monthlyPayment - interest;
			principal = principal - payPrincipal;
			OneMonthSchedule oms = new OneMonthSchedule(i, monthlyPayment, payPrincipal, interest, principal);
			list.add(oms);
			totalInterest += interest;
		}
		
		interest = principal * monthlyRate;
		monthlyPayment = principal + interest;
		OneMonthSchedule oms = new OneMonthSchedule(numOfMonths, monthlyPayment, principal, interest, 0);
		list.add(oms);
		totalInterest += interest;
		schedule.setList(list);
		schedule.setTotalInterest(totalInterest);
		
		String result = schedule.getPrincipal() + ", " + schedule.getTotalInterest() + "<br />";
		for (OneMonthSchedule om:schedule.getList()) {
			result += om.getMonth() + ", " + om.getPayment() + ", " + om.getPayPrincipal() + ", " 
					+ om.getInterest() + ", " + om.getRemainPrincipal() + "<br />";
		}
		
		return result;
	}
}
