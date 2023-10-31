package com.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CPageDTO;
import com.dto.CommentDTO;
import com.dto.PageDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.CommentService;
import com.service.MapService;

@Controller
public class CommentController {

    @Autowired
    CommentService c_service;
    
    @Autowired
    MapService service;
    // Post - Redirect - Get 방식으로 새로고침 눌렀을떄 form태그가 실행되는 것 방지
     @PostMapping("/commentAdd")
    	public String commentAdd(CommentDTO dto, RedirectAttributes m, @RequestParam (value="curPage", required = false, defaultValue = "1") int curPage,
    			@RequestParam (value="province", required = false, defaultValue = "창원") String province,
    			@RequestParam (value="city", required = false, defaultValue = "성산구") String city,
    			@RequestParam (value="citykey", required = false) String citykey
    			) {
    		
			Map<String, String> location = new HashMap<String, String>();
			location.put("province", province);
			location.put("city", city);
			location.put("citykey", citykey);

			PageDTO pagedto = service.findAll(curPage, location);
			m.addFlashAttribute("pagedto", pagedto);
			 
			c_service.insertComment(dto);
			return "redirect:Add";
		}
     
     	@GetMapping("/Add")
     	public String commentAdd2() {
     		return "main";
     	}
     	
		@GetMapping(value="/commentSelect", produces = "application/text; charset=UTF-8")
		@ResponseBody
		public String commentSelect( 
				@RequestParam (value = "fstvlNm", required = false) String fstvlNm,
				@RequestParam (value = "opar", required = false) String opar,
				@RequestParam (value = "fstvlStartDate", required = false) String fstvlStartDate,
				@RequestParam (value = "fstvlEndDate", required = false) String fstvlEndDate,
				@RequestParam (value="c_curPage", required = false, defaultValue = "1") int c_curPage
				) throws JsonProcessingException {
 			Map<String, String> listkey = new HashMap<String, String>();
			listkey.put("fstvlNm", fstvlNm);
			listkey.put("opar", opar);
			listkey.put("fstvlStartDate", fstvlStartDate);
			listkey.put("fstvlEndDate", fstvlEndDate);
			CPageDTO c_pagedto = c_service.findAll(c_curPage, listkey);
			
			ObjectMapper mapper = new ObjectMapper();
			String jsonInString = mapper.writeValueAsString(c_pagedto);
            System.out.println(jsonInString);
            
			return jsonInString;
		}

	}

