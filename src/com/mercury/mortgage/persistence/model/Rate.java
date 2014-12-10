package com.mercury.mortgage.persistence.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name="INTEREST_RATE")
@XmlRootElement
public class Rate {
	private int id;
	private String state;
	private String abbr;
	private double rate15;
	private double rate20;
	private double rate30;
	private double arm5;
	private double arm7;
	private double arm10;
	
	public Rate() {}

	@Id
    @Column(nullable = false)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	@Column
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column
	public String getAbbr() {
		return abbr;
	}

	public void setAbbr(String abbr) {
		this.abbr = abbr;
	}

	@Column
	public double getRate15() {
		return rate15;
	}

	public void setRate15(double rate15) {
		this.rate15 = rate15;
	}

	@Column
	public double getRate20() {
		return rate20;
	}

	public void setRate20(double rate20) {
		this.rate20 = rate20;
	}

	@Column
	public double getRate30() {
		return rate30;
	}

	public void setRate30(double rate30) {
		this.rate30 = rate30;
	}

	@Column
	public double getArm5() {
		return arm5;
	}

	public void setArm5(double arm5) {
		this.arm5 = arm5;
	}

	@Column
	public double getArm7() {
		return arm7;
	}

	public void setArm7(double arm7) {
		this.arm7 = arm7;
	}

	@Column
	public double getArm10() {
		return arm10;
	}

	public void setArm10(double arm10) {
		this.arm10 = arm10;
	}
}
