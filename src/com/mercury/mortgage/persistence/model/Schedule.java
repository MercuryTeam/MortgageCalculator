package com.mercury.mortgage.persistence.model;

import java.util.List;

public class Schedule {
	private List<OneMonthSchedule> list;
	private double principal;
	private double totalInterest;
	
	public Schedule() {}
	public Schedule(List<OneMonthSchedule> list, double principal, double totalInterest) {
		this.list = list;
		this.principal = principal;
		this.totalInterest = totalInterest;
	}
	
	public List<OneMonthSchedule> getList() {
		return list;
	}
	public void setList(List<OneMonthSchedule> list) {
		this.list = list;
	}
	public double getPrincipal() {
		return principal;
	}
	public void setPrincipal(double principal) {
		this.principal = principal;
	}
	public double getTotalInterest() {
		return totalInterest;
	}
	public void setTotalInterest(double totalInterest) {
		this.totalInterest = totalInterest;
	}	
}
