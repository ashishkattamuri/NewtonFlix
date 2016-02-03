package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class AngularJsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AngularJsServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(request.getParameter("movieName"));
		Client client = Client.create();
		String URL= "http://www.omdbapi.com/?s="+request.getParameter("movieName")+"&page="+request.getParameter("pageNumber")+"&r=json";
		System.out.println("URL:"+URL);
		WebResource webResource = client
				.resource(URL);
		ClientResponse clientResponse = webResource.accept("application/json")
				.get(ClientResponse.class);
		if (clientResponse.getStatus() != 200) {
			throw new RuntimeException("Failed : HTTP error code : "
					+ response.getStatus());
		}
		String output = clientResponse.getEntity(String.class);
		System.out.println("Output from Server .... \n");
		System.out.println(output);

		response.getWriter().write(output);
	}
}