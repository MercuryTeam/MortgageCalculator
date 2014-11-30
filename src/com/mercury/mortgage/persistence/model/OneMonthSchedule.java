package com.mercury.mortgage.persistence.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class OneMonthSchedule {
	private int month;
	private double payment;
	private double payPrincipal;
	private double interest;
	private double remainPrincipal;
	
	public OneMonthSchedule() {}
	public OneMonthSchedule(int month, double payment, double payPrincipal, double interest, double remainPrincipal) {
		this.month = month;
		this.payment = payment;
		this.payPrincipal = payPrincipal;
		this.interest = interest;
		this.remainPrincipal = remainPrincipal;
	}
	
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public double getPayment() {
		return payment;
	}
	public void setPayment(double payment) {
		this.payment = payment;
	}
	public double getPayPrincipal() {
		return payPrincipal;
	}
	public void setPayPrincipal(double payPrincipal) {
		this.payPrincipal = payPrincipal;
	}
	public double getInterest() {
		return interest;
	}
	public void setInterest(double interest) {
		this.interest = interest;
	}
	public double getRemainPrincipal() {
		return remainPrincipal;
	}
	public void setRemainPrincipal(double remainPrincipal) {
		this.remainPrincipal = remainPrincipal;
	}
	
	

}
