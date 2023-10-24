package com.service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service("MemberService")
public class MemberServiceImpl implements MemberService{

    @Autowired
    MemberDAO dao;
    @Override
    public MemberDTO idCheck(String userid) {
        return dao.idCheck(userid);
    }

    @Override
    public int memberAdd(MemberDTO dto) {
        return dao.memberAdd(dto);
    }

    @Override
    public MemberDTO login(HashMap<String, String> map) {
        return dao.login(map);
    }

    @Override
    public MemberDTO mypage(String userid) {
        return dao.mypage(userid);
    }
}
