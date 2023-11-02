package com.service;

import com.dto.MemberDTO;

import java.util.HashMap;

public interface MemberService {

    public MemberDTO idCheck(String userid);
    public int memberAdd(MemberDTO dto);
    public MemberDTO login(HashMap<String, String> map);
    public MemberDTO mypage(String userid);
}
