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

	public Schedule getCalculatingResult(double principal, String term, String state, double extra, int extraDuration) {
		Schedule schedule = null;
		Schedule scheduleNoExtra = null;
		double savedInterest;
		int numOfMonths = Integer.parseInt(term) * 12;
		double rate = getInterestRate(term, state);		
		
		if ("15".equals(term) || "20".equals(term) || "30".equals(term)) {
			schedule = fixedCalculating(principal, numOfMonths, rate, extra, extraDuration);
			scheduleNoExtra = fixedCalculating(principal, numOfMonths, rate, 0, 0);			
		} else {
			schedule = armCalculating(principal, numOfMonths, rate, extra, extraDuration);
			scheduleNoExtra = armCalculating(principal, numOfMonths, rate, 0, 0);
		}
		savedInterest = scheduleNoExtra.getTotalInterest() - schedule.getTotalInterest();
		schedule.setSavedInterest(savedInterest);
		
		return schedule;
	}	
	
	// Calculating fixed rate mortgage schedule
	private Schedule fixedCalculating(double principal, int numOfMonths, double rate, double extra, int extraDuration) {
		Schedule schedule = new Schedule();
		schedule.setPrincipal(principal);
		schedule.setList(new ArrayList<OneMonthSchedule>());
		
		double monthlyRate = rate / 12;
		double monthlyPayment = principal * (monthlyRate / (1 - Math.pow(1 + monthlyRate, -numOfMonths)));
		principal = calculating(principal, numOfMonths, monthlyRate, monthlyPayment, extra, extraDuration, 1, schedule);
		
		return schedule;
	}
	
	// Calculating adjustable rate mortgage schedule
	private Schedule armCalculating(double principal, int initialDuration, double rate, double extra, int extraDuration) {
		Schedule schedule = new Schedule();
		schedule.setPrincipal(principal);
		schedule.setList(new ArrayList<OneMonthSchedule>());
		
		int startMonth = 1;
		double monthlyRate = rate / 12;
		int numOfMonths = 30 * 12;
		double monthlyPayment = principal * (monthlyRate / (1 - Math.pow(1 + monthlyRate, -numOfMonths)));
		
		// Calculating initial schedule
		principal = calculating(principal, initialDuration, monthlyRate, monthlyPayment, extra, extraDuration, startMonth, schedule);
		
		// Calculating rest schedule
		startMonth += initialDuration;
		numOfMonths = numOfMonths - initialDuration;
		extraDuration = (extraDuration - initialDuration < 0) ? 0 : (extraDuration - initialDuration);
		while (principal != 0) {
			rate = rate - 0.025 / 100;
			monthlyRate = rate / 12;
			monthlyPayment = principal * (monthlyRate / (1 - Math.pow(1 + monthlyRate, -numOfMonths)));
			principal = calculating(principal, 12, monthlyRate, monthlyPayment, extra, extraDuration, startMonth, schedule);
			startMonth += 12;
			numOfMonths = numOfMonths - 12;
			extraDuration = (extraDuration - 12 < 0) ? 0 : (extraDuration - 12);
		}
		
		return schedule;
	}
	
	
	private double calculating(double principal, int duration, double monthlyRate, double monthlyPayment, 
			 					double extra, int extraDuration, int startMonth, Schedule schedule) {
		if (extraDuration >= duration) {
			principal = calculating(principal, duration, monthlyRate, monthlyPayment + extra, startMonth, schedule);
		} else {
			// Calculating schedule with additional principal
			principal = calculating(principal, extraDuration, monthlyRate, monthlyPayment + extra, startMonth, schedule);
			// Calculating rest schedule without additional principal
			if (principal != 0) {
				principal = calculating(principal, duration - extraDuration, monthlyRate, monthlyPayment, extraDuration + startMonth, schedule);
			}
		}

		return principal;
	}
	
	
	private double calculating(double principal, int numOfMonths, double monthlyRate, 
							double monthlyPayment, int startMonth, Schedule schedule) {
		double totalInterest = 0;
		double interest = principal * monthlyRate;
		double payPrincipal = monthlyPayment - interest;
		List<OneMonthSchedule> list = schedule.getList();
		
		int i;
		for (i = startMonth; (i < startMonth + numOfMonths) && (monthlyPayment < principal); i++) {
			principal = principal - payPrincipal;
			OneMonthSchedule oms = new OneMonthSchedule(i, monthlyPayment, payPrincipal, interest, principal);
			list.add(oms);
			totalInterest += interest;
			interest = principal * monthlyRate;
			payPrincipal = monthlyPayment - interest;
		}
		
		if (i < startMonth + numOfMonths) {
			interest = principal * monthlyRate;
			payPrincipal = principal;
			monthlyPayment = payPrincipal + interest;
			principal = 0;
			OneMonthSchedule oms = new OneMonthSchedule(i, monthlyPayment, payPrincipal, interest, principal);
			list.add(oms);
			totalInterest += interest;
		}
		schedule.setTotalInterest(schedule.getTotalInterest() + totalInterest);
		
		return principal;
	}
	
	
	private double getInterestRate(String term, String state) {
		Map<String, Double> map = new HashMap<String, Double>();
		Rate interestRate = hd.findBy("abbr", state);
		map.put("15", interestRate.getRate15());
		map.put("20", interestRate.getRate20());
		map.put("30", interestRate.getRate30());
		map.put("5", interestRate.getArm5());
		map.put("7", interestRate.getArm7());
		map.put("10", interestRate.getArm10());
		return map.get(term) / 100;
	}
	
	
}
