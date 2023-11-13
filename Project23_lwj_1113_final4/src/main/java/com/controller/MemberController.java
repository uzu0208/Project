package com.controller;

import com.dto.MailDTO;
import com.dto.MemberDTO;
import com.mail.GenerateKey;
import com.mail.MailHandler;
import com.service.MailService;
import com.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Controller
public class MemberController {

    @Autowired
    MemberService service;
    
    @Autowired
    MailService mailService;

    @Autowired
    JavaMailSender mailSender;
    
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

    @PostMapping(value = "MemberAdd", produces = "text/plain;charset=utf-8")
    public ResponseEntity<String> memberAdd(@RequestBody MemberDTO dto){

        Map<String, String> map = new HashMap<>();
        map.put("email1", dto.getEmail1());
        map.put("email2", dto.getEmail2());

        if (service.checkEmailDuplicate(map) != 0){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 사용하는 이메일입니다.");
        }

        // 계정을 추가하고 인증한 이메일의 인증키 삭제
        service.memberAdd(dto);
        service.deleteEmailKey(map);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/memberManagement/admin")
    public String adminAuthority(){

        return "admin/memberManagement";
    }

    @GetMapping("/Idcheck/login")
    @ResponseBody
    public String idcheck(HttpServletRequest request) {

        HttpSession session = request.getSession();
        MemberDTO dto = (MemberDTO)session.getAttribute("login");

        Map<String, String> map = new HashMap<String, String>();
        String id = dto.getUserid();
        String isadmin = dto.getIsAdmin();
        return id+"/"+isadmin;
    }

    @PostMapping("/memberUpdatePassword/login")
    public void memberUpdatePassword(@RequestParam Map<String, String> map, HttpServletResponse response,
                                       HttpSession session, HttpServletRequest request) throws IOException {

        MemberDTO dto = (MemberDTO) session.getAttribute("login");

        if (!(service.checkPassword(dto.getUserid(), map.get("password")))){

            // 비밀번호 변경
            service.memberPasswordUpdate(map);

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
    }

    @GetMapping("updateMemberInfo/login")
    public void updateMemberInfo(@RequestParam Map<String, String> map, HttpSession session, HttpServletResponse response,
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

    }
    // 이메일 인증키를 보내는 메서드
    @GetMapping("sendMailKey")
    @ResponseBody
    public String sendMailKey(@RequestParam String email1, @RequestParam String email2, GenerateKey key, HttpServletRequest request,
                              Map<String, String> map, MailDTO dto)
            throws MessagingException, UnsupportedEncodingException {

        map.put("email1",email1);
        map.put("email2", email2);

        if (service.checkEmailDuplicate(map) != 0){

            return "emailDuplicate";
        }

        String mailKey = key.getKey(30);

        MailHandler mailHandler = new MailHandler(mailSender);
        mailHandler.setSubject("인증메일입니다.");
        mailHandler.setText(
                "<h1>메일인증<h1>" +
                        "아래 인증키를 입력해주세요.<br>" +
                        "<span>" + mailKey + "</span>"
        );
        mailHandler.setFrom("iuju493@gmail.com", "축제");
        mailHandler.setTo(email1 + "@" + email2);
        mailHandler.send();




        mailService.insertEmail(map);

        dto.setMailKey(mailKey);
        dto.setEmail1(email1);
        dto.setEmail2(email2);

        mailService.updateMailKey(dto);

        return "";
    }

    // 이메일 인증키를 인증하는 메서드
    @GetMapping(value = "checkMailKey", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String checkMailKey(@RequestParam String email1, @RequestParam String email2, @RequestParam String mailKey,
                               MailDTO dto){

        dto.setMailKey(mailKey);
        dto.setEmail1(email1);
        dto.setEmail2(email2);

        if (mailService.updateMailAuth(dto) != 0){

            return "인증 완료";
        }else {
            return "인증 실패";
        }
    }

    // 이메일 인증을 확인하는 메서드
    @GetMapping("checkMailAuth")
    @ResponseBody
    public ResponseEntity<String> checkMailAuth(@RequestParam String email1, @RequestParam String email2, @RequestParam String mailKey,
                                        Map<String, String> map){
        map.put("email1",email1);
        map.put("email2", email2);

        if (mailService.emailIsAuthFail(map) != 0){
            return new ResponseEntity<>("", HttpStatus.OK);
        }else {
            return new ResponseEntity<>("", HttpStatus.UNAUTHORIZED);
        }
    }

    // 계정을 삭제하는 메서드
    @GetMapping("deleteMember/login")
    public String deleteMember(HttpSession session, HttpServletResponse response){


        String userid = ((MemberDTO)session.getAttribute("login")).getUserid();
        service.deleteMember(userid);
        session.invalidate();

        // 캐시를 삭제하여 로그아웃 후 뒤로가기 시 로그인 한 후 화면이 나오지 않도록 함
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        return "redirect:/main";
    }
}

