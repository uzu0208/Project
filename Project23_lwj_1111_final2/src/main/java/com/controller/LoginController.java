package com.controller;

import com.dto.MemberDTO;
import com.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Objects;

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

    @GetMapping("mypage/login")
    public String mypage(){

        return "member/mypagepasswordCheck";
    }

    @GetMapping("mypageHome/login")
    public String mypageHome(){

        return "member/mypageHome";
    }

    @PostMapping("checkPassword/login")
    public String checkPassword(@RequestParam String password, HttpSession session, HttpServletResponse response,
                                HttpServletRequest request) throws IOException {

        String referer = request.getHeader("Referer");


        MemberDTO checkdto = (MemberDTO) session.getAttribute("login");

        String nextPage = "";
        if (service.checkPassword(checkdto.getUserid(), password)){
            if (referer != null && referer.contains("mypageHome/login")){
            	nextPage = "redirect:/mypageChangePassword/login";
            }else {
                nextPage = "redirect:/mypageHome/login";
            }
        }else {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 맞지 않습니다.'); history.go(-1) </script>");
            out.flush();
        }

        if (!nextPage.isEmpty()){
            return nextPage;
        }else {
            return null;
        }
    }

    @GetMapping("/mypageChangePassword/login")
    public String mypageChangePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String referer = request.getHeader("Referer");

        // 비밀번호를 입력하지 않고 URL로 접근 시 접근 막기
        if (referer == null || !(referer.contains("mypageHome/login"))){
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('허용하지 않은 접근입니다.'); history.go(-1) </script>");
            out.flush();
        }

        return "member/mypageChangePassword";
    }
}
