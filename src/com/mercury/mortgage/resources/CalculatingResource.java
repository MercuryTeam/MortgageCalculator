package com.mercury.mortgage.resources;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.mortgage.persistence.model.Schedule;
import com.mercury.mortgage.service.CalculatingService;

@Component
@Path("/calculating")
public class CalculatingResource {
	@Autowired
	private CalculatingService cs;

	@POST
	@Produces({MediaType.APPLICATION_JSON})
	public Schedule calculating(@FormParam("principal") String principal, 
								@FormParam("loadTerm") String term, @FormParam("zipCode") String zipCode) {
		double pl = Double.parseDouble(principal);
		return cs.getCalculatingResult(pl, term, zipCode);
	}
	
	
}
