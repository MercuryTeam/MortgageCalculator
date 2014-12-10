package com.mercury.mortgage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.mortgage.persistence.model.Rate;

@Service
@Transactional
public class AdminService {
	@Autowired
	@Qualifier("rateDao")
	private HibernateDao<Rate, Integer> hd;
		
	public HibernateDao<Rate, Integer> getHd() {
		return hd;
	}

	public void setHd(HibernateDao<Rate, Integer> hd) {
		this.hd = hd;
	}

	
	public List<Rate> getAllRates() {
		return hd.findAll();
	}
	
	public String updateRate(Rate rate) {
		hd.save(rate);
		return "Success!";
	}
}
