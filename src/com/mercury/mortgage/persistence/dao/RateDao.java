package com.mercury.mortgage.persistence.dao;

import com.mercury.mortgage.persistence.model.Rate;

public interface RateDao {
	public Rate getRateByZipCode(String zipCode);
}
