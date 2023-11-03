package com.interceptor;

import com.dto.MemberDTO;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Objects;

@Component("adminCheck")
public class AdminCheckHandlerInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 로그인 체크
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");

        if (memberDTO == null) {
            response.sendRedirect(request.getContextPath() + "/loginUI");
            return false;
        } else if (Objects.equals(memberDTO.getIsAdmin(), "0")) {
            response.setContentType("text/html; charset=UTF-8");

            PrintWriter out = response.getWriter();

            out.println("<script>" +
                                    "alert('권한이 없습니다.'); " +
                                    "history.go(-1);" +
                                "</script>");

            out.flush();
            return false;
        } else {
            return true;
        }
    }
}
