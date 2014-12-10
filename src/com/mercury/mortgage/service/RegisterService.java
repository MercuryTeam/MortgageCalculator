package com.mercury.mortgage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.mortgage.mail.MailAppBean;
import com.mercury.mortgage.persistence.model.Person;

@Service
@Transactional
public class RegisterService {
	@Autowired
	@Qualifier("personDao")
	private HibernateDao<Person, Integer> pd;
	@Autowired
	private MailAppBean mb;

	public HibernateDao<Person, Integer> getPd() {
		return pd;
	}

	public void setPd(HibernateDao<Person, Integer> pd) {
		this.pd = pd;
	}
		
	public String registerNewUserAccount(String username, final String email, String password) {
        createAccount(username, email, password);
        new Thread(new Runnable() {
			@Override
			public void run() {
				sendMail(email);
			}        	
        }).start();    
        
        return "Success!";
    }
	
	private void createAccount(String username, String email, String password) {
		Person person = new Person();
        person.setUsername(username);
        person.setEmail(email);
     // Encrypt password
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashedPassword = passwordEncoder.encode(password);
        person.setPassword(hashedPassword);       
        //person.setPassword(password);
        person.setAuthority("ROLE_USER");
        //person.setAuthority("ROLE_ADMIN");
        person.setEnabled(false);
        pd.save(person);
	}
	
	
	private void sendMail(String email) {
		Person person = pd.findBy("email", email);
		String salt = BCrypt.gensalt(12);
		String hash = BCrypt.hashpw(String.valueOf(person.getPersonId()), salt);
		String username = person.getUsername();
		String link = "http://localhost:8080/MortgageCalculator/rest/registering/verify?verifyKey=" + hash + "&username=" + username;
		mb.sendMail(email, link, username);
	}
	
	public String verify(String key, String username) {
		Person person = pd.findBy("username", username);
		boolean isEqual = BCrypt.checkpw(String.valueOf(person.getPersonId()), key);
		
		if (isEqual) {
			person.setEnabled(true);
			pd.save(person);
			return "Success";
		}
		
		return "Failed";
	}
	
	public String userNameExist(String username) {
        Person person = pd.findBy("username", username); 
        if (person != null) {
            return "true";
        }
        return "false";
	}
	
	public String emailExist(String email) {
		Person person = pd.findBy("email", email);
		if (person != null) {
            return "true";
        }
        return "false";
	}
}
