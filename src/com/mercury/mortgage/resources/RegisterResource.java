package com.mercury.mortgage.resources;

import java.net.URI;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.mortgage.service.RegisterService;

@Component
@Path("/registering")
public class RegisterResource {
	@Autowired
	private RegisterService rs;

	@POST
	@Produces({MediaType.TEXT_HTML})
	public String registering(@FormParam("username") String username, 
								@FormParam("email") String email, @FormParam("password") String password) {
		return rs.registerNewUserAccount(username, email, password);
	}
	
	
	@GET
	@Path("/usernameCheck")
	@Produces({MediaType.TEXT_HTML})
	public String userNameExist(@QueryParam("username") String username) {
		return rs.userNameExist(username);
	}
	
	@GET
	@Path("/emailCheck")
	@Produces({MediaType.TEXT_HTML})
	public String emailExist(@QueryParam("email") String email) {
		return rs.emailExist(email);
	}

	@GET
	@Path("/verify")
	public Response verify(@QueryParam("verifyKey") String key, @QueryParam("username") String username) {
		String isSuccess = rs.verify(key, username);
		URI redirectUrl = UriBuilder.fromUri("http://localhost:8080/MortgageCalculator/").queryParam("isSuccess", isSuccess).build();
		return Response.seeOther(redirectUrl).build();
	}
}
