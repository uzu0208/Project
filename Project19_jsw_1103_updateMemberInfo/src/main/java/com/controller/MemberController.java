package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.Objects;

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

    @PostMapping("/memberUpdatePassword/login")
    public String memberUpdatePassword(@RequestParam Map<String, String> map, HttpServletResponse response,
                                       HttpSession session, HttpServletRequest request) throws IOException {

        MemberDTO dto = service.mypage(map.get("userid"));

        if (!Objects.equals(dto.getPassword(), map.get("password"))){

            // 비밀번호 변경
            service.memberPasswordUpdate(map);

            // 세션 초기화(초기화하지 않으면 기존 비밀번호가 유지)
            dto = service.mypage(map.get("userid"));
            session.setAttribute("login", dto);

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 변경되었습니다.'); location.href='" + request.getContextPath() + "/mypageHome/login'</script>");
            out.flush();
        }else {

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 기존의 비밀번호와 일치합니다.'); history.go(-1) </script>");
            out.flush();
        }
        return "";
    }

    @GetMapping("updateMemberInfo/login")
    public String updateMemberInfo(@RequestParam Map<String, String> map, HttpSession session, HttpServletResponse response,
                                   HttpServletRequest request) throws IOException {

        // 계정 정보 수정
        service.updateMemberInfo(map);

        // 수정한 계정 정보를 세션에 저장
        MemberDTO dto = service.mypage(map.get("userid"));
        session.setAttribute("login", dto);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('계정 정보가 변경되었습니다.'); location.href='" + request.getContextPath() + "/mypageHome/login'</script>");
        out.flush();

        return "";
    }
}
