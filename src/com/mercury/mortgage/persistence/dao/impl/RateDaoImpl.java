package com.mercury.mortgage.persistence.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.mercury.mortgage.persistence.dao.RateDao;
import com.mercury.mortgage.persistence.model.Rate;

@Repository
public class RateDaoImpl implements RateDao {
	@Autowired 
	@Qualifier("appSessionFactory")
    private SessionFactory sessionFactory;

    public Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

	@Override
	public Rate getRateByZipCode(String zipCode) {
		Criteria ct = this.getCurrentSession().createCriteria(Rate.class);
		return (Rate)ct.add(Restrictions.eq("zipCode", zipCode)).uniqueResult();
	}

}
