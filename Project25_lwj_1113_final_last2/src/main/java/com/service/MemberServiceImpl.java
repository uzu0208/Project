package com.service;

import com.dao.MailDAO;
import com.dao.MemberDAO;
import com.dto.MemberDTO;
import com.hash.Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service("MemberService")
public class MemberServiceImpl implements MemberService{

    @Autowired
    MemberDAO dao;

    @Autowired
    MailDAO mailDAO;

    @Autowired
    Encrypt encrypt;

    @Autowired
    JavaMailSender mailSender;

    // 아이디 중복 확인
    @Override
    public MemberDTO idCheck(String userid) {
        return dao.idCheck(userid);
    }

    // 계정 추가
    @Override
    public int memberAdd(MemberDTO dto) {

        dto.setPassword(encrypt.encrypt(dto.getPassword()));
        return  dao.memberAdd(dto);
    }

    // 로그인
    // 로그인
    @Override
    public MemberDTO login(HashMap<String, String> map) {
    	
    	MemberDTO resultdto = null;
    	
    	try{
    		 if (encrypt.isMatchPassword(map.get("password"), dao.checkPassword(map.get("userid")))){
    			 resultdto = dao.login(map);
    	        }
    	}catch (Exception e) {
    			 resultdto = null;
		}
    	
    	return resultdto;
       
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

    // 이메일 중복 확인
    @Override
    public int checkEmailDuplicate(Map<String, String> map) {
        return dao.checkEmailDuplicate(map);
    }

    // 인증한 이메일 인증키 삭제
    @Override
    public int deleteEmailKey(Map<String, String> map) {
        return dao.deleteEmailKey(map);
    }

    // 계정 삭제 및 인증한 메일도 삭제
    @Transactional
    @Override
    public int deleteMember(String userid) {

        MemberDTO dto = dao.mypage(userid);

        Map<String, String> map = new HashMap<>();

        map.put("email1", dto.getEmail1());
        map.put("email2", dto.getEmail2());

        mailDAO.deleteMail(map);

        return dao.deleteMember(userid);
    }

}
