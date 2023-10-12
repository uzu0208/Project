package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dto.MapDTO;
import com.service.MapService;

@Controller
public class MapController {
	
	@Autowired
	MapService service;
	
	@GetMapping("/main")  
	// http://localhost:8090/app/main
	public String main(Model m) {
		
		List<MapDTO> list = service.findAll();
		m.addAttribute("list",list);
		// --> 모델은 key="list" , value = list(레코드들)
		
		return "main"; // view 정보 --> /WEB-INF/views/main.jsp
	}

}
