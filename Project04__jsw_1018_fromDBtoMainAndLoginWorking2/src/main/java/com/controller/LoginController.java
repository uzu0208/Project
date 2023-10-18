package com.controller;

import com.dto.MemberDTO;
import com.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
public class LoginController {

    @Autowired
    MemberService service;

    @GetMapping("loginUI")
    public String loginUI(){
        return "loginForm";
    }

    @GetMapping("login")
    public String login(@RequestParam HashMap<String, String> map, HttpSession session){
        MemberDTO dto = service.login(map);
        String nextPage = null;
        if(dto != null){
            nextPage = "redirect:main";
            // 세션처리
            session.setAttribute("login", dto);
        }else {
            nextPage = "member/loginFail";
        }
        return nextPage;
    }
}
