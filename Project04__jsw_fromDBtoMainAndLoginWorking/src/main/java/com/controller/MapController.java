package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MapDTO;
import com.dto.PageDTO;
import com.service.MapService;

@Controller
public class MapController {

    @Autowired
    MapService service;

    @GetMapping("/main")  
	// http://localhost:8090/app/main
	public String main(Model m, @RequestParam (value="curPage", required = false, defaultValue = "1") int curPage) {
		
    	String location = "창원";
    	PageDTO pagedto = service.findAll(curPage,location);
		m.addAttribute("pagedto",pagedto);
		
		return "main"; // view 정보 --> /WEB-INF/views/main.jsp
	}
	 
}
