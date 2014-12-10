package com.mercury.mortgage.resources;

import java.util.List;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.mortgage.persistence.model.Rate;
import com.mercury.mortgage.service.AdminService;


@Component
@Path("/admin")
public class AdminResource {
	@Autowired
	private AdminService as;
	
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public List<Rate> showRates() {
		return as.getAllRates();
	}
	
	@POST
	@Path("/update")
	@Produces({MediaType.TEXT_HTML})
	public String updateRate(@FormParam("id") String id, 
			@FormParam("state") String state, @FormParam("abbr") String abbr,
			@FormParam("rate15") String rate15, @FormParam("rate20") String rate20,
			@FormParam("rate30") String rate30, @FormParam("arm5") String arm5,
			@FormParam("arm7") String arm7, @FormParam("arm10") String arm10) {
		Rate rate = new Rate();
		rate.setId(Integer.parseInt(id));
		rate.setState(state);
		rate.setAbbr(abbr);
		rate.setRate15(Double.parseDouble(rate15));
		rate.setRate20(Double.parseDouble(rate20));
		rate.setRate30(Double.parseDouble(rate30));
		rate.setArm5(Double.parseDouble(arm5));
		rate.setArm7(Double.parseDouble(arm7));
		rate.setArm10(Double.parseDouble(arm10));
		return as.updateRate(rate);
	}

}
