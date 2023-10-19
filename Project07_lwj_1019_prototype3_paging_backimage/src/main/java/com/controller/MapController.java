package com.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.PageDTO;
import com.service.MapService;

@Controller
public class MapController {

    @Autowired
    MapService service;

    @GetMapping("/main")  
	// http://localhost:8090/app/main
	public String main(Model m, @RequestParam (value="curPage", required = false, defaultValue = "1") int curPage,
			@RequestParam (value="province", required = false, defaultValue = "창원") String province,
			@RequestParam (value="city", required = false, defaultValue = "성산구") String city
			) {
		
    	Map<String,String> location = new HashMap<String, String>();
    	location.put("province", province);
    	location.put("city", city);
    	
    	PageDTO pagedto = service.findAll(curPage,location);
		m.addAttribute("pagedto",pagedto);
		
		return "main";  
	}
	 
}
