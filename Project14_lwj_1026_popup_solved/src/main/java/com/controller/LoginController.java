package com.controller;

import com.dto.MemberDTO;
import com.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    @GetMapping("logout/login")
    public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response){
        // 세션 삭제
        session.invalidate();

        // 캐시를 삭제하여 로그아웃 후 뒤로가기 시 로그인 한 후 화면이 나오지 않도록 함
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        return "redirect:/main";
    }
}
