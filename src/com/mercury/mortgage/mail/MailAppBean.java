package com.mercury.mortgage.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailParseException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailAppBean {
	private JavaMailSender mailSender;
	private SimpleMailMessage simpleMailMessage;
	
	public JavaMailSender getMailSender() {
		return mailSender;
	}
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	public SimpleMailMessage getSimpleMailMessage() {
		return simpleMailMessage;
	}
	public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
		this.simpleMailMessage = simpleMailMessage;
	}

	public void sendMail(String email, String link, String username) {
		MimeMessage message = mailSender.createMimeMessage();
		try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(simpleMailMessage.getFrom());
			helper.setTo(email);
			helper.setSubject(simpleMailMessage.getSubject());
			helper.setText(String.format(simpleMailMessage.getText(), username, link));

		} catch (MessagingException e) {
			throw new MailParseException(e);
		}
		mailSender.send(message);
	}
}
