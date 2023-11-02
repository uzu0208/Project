package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {

    @Autowired
    MemberService service;

    @GetMapping(value = "MemberIdCheck", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String idCheck(@RequestParam("userid") String userid){
        MemberDTO dto = service.idCheck(userid);
        String mesg = "아이디 사용 가능";
        if (dto != null){
            mesg = "아이디 중복";
        }
        return mesg;
    }

    @GetMapping("memberUI")
    public String memberUI(){
        return "memberForm";
    }

    @PostMapping("MemberAdd")
    public String memberAdd(MemberDTO dto){
        service.memberAdd(dto);

        return "redirect:loginUI";
    }

    @GetMapping("/memberManagement/admin")
    public String adminAuthority(){

        return "admin/memberManagement";
    }
    
    @GetMapping("/Idcheck")
    @ResponseBody
    public String idcheck(HttpServletRequest request) {
    	
    	HttpSession session = request.getSession();
    	MemberDTO dto = (MemberDTO)session.getAttribute("login");
    	
    	String id = dto.getUserid();
    	return id;
    }
}
