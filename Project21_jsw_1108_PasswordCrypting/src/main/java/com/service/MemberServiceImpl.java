package com.service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;
import com.hash.Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("MemberService")
public class MemberServiceImpl implements MemberService{

    @Autowired
    MemberDAO dao;

    @Autowired
    Encrypt encrypt;

    // 아이디 중복 확인
    @Override
    public MemberDTO idCheck(String userid) {
        return dao.idCheck(userid);
    }

    // 계정 추가
    @Override
    public int memberAdd(MemberDTO dto) {
        dto.setPassword(encrypt.encrypt(dto.getPassword()));
        return dao.memberAdd(dto);
    }

    // 로그인
    @Override
    public MemberDTO login(HashMap<String, String> map) {

        if (encrypt.isMatchPassword(map.get("password"), dao.checkPassword(map.get("userid")))){
            return dao.login(map);
        }
        return null;
    }

    // 마이 페이지 정보 가져오기
    @Override
    public MemberDTO mypage(String userid) {
        return dao.mypage(userid);
    }

    // 비밀번호 수정
    @Override
    public int memberPasswordUpdate(Map<String, String> map) {

        map.put("password", encrypt.encrypt(map.get("password")));
        return dao.memberPasswordUpdate(map);
    }

    // 계정 정보 수정
    @Override
    public int updateMemberInfo(Map<String, String> map) {
        return dao.updateMemberInfo(map);
    }

    // 비밀번호 확인
    @Override
    public boolean checkPassword(String userid, String password) {
        return encrypt.isMatchPassword(password, dao.checkPassword(userid));
    }
}
