package com.interceptor;

import com.dto.MemberDTO;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component("loginCheck")
public class LoginCheckHandlerInterceptor  extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 로그인 체크
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");

        if(memberDTO == null){
            response.sendRedirect(request.getContextPath() + "/loginUI");
            return false;
        }

        return true;
    }
}
