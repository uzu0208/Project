package com.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CPageDTO;
import com.dto.CommentDTO;
import com.dto.MemberDTO;
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
    			@RequestParam (value="province", required = false) String province,
    			@RequestParam (value="city", required = false) String city,
    			@RequestParam (value="citykey", required = false) String citykey
    			) {
    	 
			Map<String, String> location = new HashMap<String, String>();
			location.put("province", province);
			location.put("city", city);
			location.put("citykey", citykey);

			PageDTO pagedto = service.findAll(curPage, location);
			m.addFlashAttribute("pagedto", pagedto);
			m.addAttribute("curPage", curPage);
	 
			c_service.insertComment(dto);
			return "redirect:Add";
		}
     
     	@GetMapping("/Add")
     	public String commentAdd2(@ModelAttribute ("pagedto") PageDTO dto, Model m2, @ModelAttribute("curPage") String curPage) {

     		Map<String, String> location = dto.getLocation();

     		m2.addAttribute("province", location.get("province"));
     		m2.addAttribute("city", location.get("city"));
     		m2.addAttribute("citykey", location.get("citykey"));
     		m2.addAttribute("curPage", curPage);
     		
     		return "redirect:main";
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
		
		@GetMapping("/deleteComment")
		@ResponseBody
     	public void deleteComment(@RequestParam String rno) {
			c_service.deleteComment(rno);
     	}
		
		@GetMapping("/findUserReply/admin")
		public String findUserReply(@RequestParam (value="curPage", required = false, defaultValue = "1") int u_curPage, Model m,
									@RequestParam (value="rid", required = false) String rid
				) {
			
			CPageDTO u_pagedto = c_service.findUserReply(u_curPage, rid);
			
			m.addAttribute("u_pagedto", u_pagedto);
			
			if(rid!=null) {
				m.addAttribute("ischanged", 1);
				return "admin/memberManagement";
			}else {
				m.addAttribute("ischanged", 0);
				return "admin/memberManagement";
			}
		}

		@GetMapping("/findByDropdown/admin")
		public String findByDropdown(
				@RequestParam(value = "curPage", required = false, defaultValue = "1") int s_curPage, Model m,
				@RequestParam(value = "contents", required = false) String contents, @RequestParam(value = "option", required = false) String option ) {

			 
			 CPageDTO s_pagedto = c_service.findSelectedReply(s_curPage, contents, option);
			 m.addAttribute("u_pagedto", s_pagedto);
			 
			 return "admin/memberManagement";
		}
		
	}

