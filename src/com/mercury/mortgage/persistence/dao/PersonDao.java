package com.mercury.mortgage.persistence.dao;

import com.mercury.mortgage.persistence.model.Person;

public interface PersonDao {
	public Person getPersonById(int personId);
	public Person getPersonByUsername(String username);
}
