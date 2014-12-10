package com.mercury.mortgage.persistence.model;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Schedule {
	private List<OneMonthSchedule> list;
	private double principal;
	private double totalInterest;
	private double savedInterest;
	
	public Schedule() {}
	public Schedule(List<OneMonthSchedule> list, double principal, double totalInterest) {
		this.list = list;
		this.principal = principal;
		this.totalInterest = totalInterest;
	}
	
	@XmlElement(name="Schedule")
	public List<OneMonthSchedule> getList() {
		return list;
	}
	public void setList(List<OneMonthSchedule> list) {
		this.list = list;
	}
	
	@XmlElement(name="Principal")
	public double getPrincipal() {
		return principal;
	}
	public void setPrincipal(double principal) {
		this.principal = principal;
	}
	
	@XmlElement(name="TotalInterest")
	public double getTotalInterest() {
		return totalInterest;
	}
	public void setTotalInterest(double totalInterest) {
		this.totalInterest = totalInterest;
	}
	
	@XmlElement(name="SavedInterest")
	public double getSavedInterest() {
		return savedInterest;
	}
	public void setSavedInterest(double savedInterest) {
		this.savedInterest = savedInterest;
	}	
}
