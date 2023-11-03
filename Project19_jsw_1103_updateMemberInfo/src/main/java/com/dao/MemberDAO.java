package com.dao;

import com.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository("MemberDAO")
public class MemberDAO {

    @Autowired
    SqlSessionTemplate session;

    // id 중복확인
    public MemberDTO idCheck(String userid){
        return session.selectOne("MemberMapper.idCheck", userid);
    }

    // 회원가입
    public int memberAdd(MemberDTO dto) {
        return session.insert("MemberMapper.memberAdd", dto);
    }

    // 로그인
    public MemberDTO login(HashMap<String, String> map) {
        return session.selectOne("MemberMapper.login", map);
    }

    // mypage
    public MemberDTO mypage(String userid) {
        return session.selectOne("MemberMapper.mypage", userid);
    }

    // 계정 비밀번호 바꾸기
    public int memberPasswordUpdate(Map<String, String> map){
        return session.update("MemberMapper.memberPasswordUpdate", map);
    }

    // 계정 정보 수정
    public int updateMemberInfo(Map<String, String> map){
        return session.update("MemberMapper.updateMemberInfo", map);
    }
}
