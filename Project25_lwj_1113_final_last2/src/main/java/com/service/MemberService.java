package com.service;

import com.dto.MemberDTO;

import javax.mail.MessagingException;
import java.util.HashMap;
import java.util.Map;

public interface MemberService {

    public MemberDTO idCheck(String userid);
    public int memberAdd(MemberDTO dto);
    public MemberDTO login(HashMap<String, String> map);
    public MemberDTO mypage(String userid);
    public int memberPasswordUpdate(Map<String, String> map);
    public int updateMemberInfo(Map<String, String> map);
    public boolean checkPassword(String userid, String password);
    public int checkEmailDuplicate(Map<String, String> map);
    public int deleteEmailKey(Map<String, String> map);
    public int deleteMember(String userid);
}
