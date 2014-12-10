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
								@FormParam("loadTerm") String term, @FormParam("state") String state,
								@FormParam("extra") String extra, @FormParam("extraDuration") String extraDuration) {
		double pl = Double.parseDouble(principal);
		double et = Double.parseDouble(extra);
		int ed = Integer.parseInt(extraDuration);
		return cs.getCalculatingResult(pl, term, state, et, ed);
	}
	
	
}
