package com.dao;

import com.dto.MailDTO;
import com.dto.MapDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class MailDAO {

    @Autowired
    SqlSessionTemplate session;

    /**
     * 이메일에 대해 인증코드와 인증유효기간(5분) update
     * @param dto 이메일과 인증코드
     * @return update 성공 여부
     */
    public int updateMailKey(MailDTO dto){
        return session.update("MailMapper.updateMailKey", dto);
    }

    /**
     * 이메일을 DB에 저장한다. 이미 이메일이 있다면 저장하지 않는다.
     * @param map email에 대한 정보 (@를 기준으로 key값은 email1, email2)
     * @return insert 성공 여부
     */
    public int insertEmail(Map<String, String> map){
        return session.insert("MailMapper.insertEmail", map);
    }

    /**
     * 이메일과 인증코드와 유효기간 내라면 인증완료
     * @param dto 이메일과 인증코드
     * @return update 성공여부
     */
    public int updateMailAuth(MailDTO dto){
        return session.update("MailMapper.updateMailAuth", dto);
    }

    /**
     * 이메일을 인증한 상태인 지 확인한다.
     * @param map email에 대한 정보 (@를 기준으로 key값은 email1, email2)
     * @return 이메일 인증 여부 ( 0이면 인증하지 않음)
     */
    public int emailIsAuthFail(Map<String, String> map){
        return session.selectOne("MailMapper.emailIsAuthFail", map);
    }

    /**
     * 이메일을 삭제한다..
     * @param map email에 대한 정보 (@를 기준으로 key값은 email1, email2)
     * @return 이메일 삭제 여부 ( 0이면 삭제실패)
     */
    public int deleteMail(Map<String, String> map){
        return session.delete("MailMapper.deleteMail", map);
    }
}
