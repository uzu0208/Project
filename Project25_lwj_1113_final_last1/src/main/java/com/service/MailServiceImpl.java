package com.service;

import com.dao.MailDAO;
import com.dto.MailDTO;
import com.dto.MapDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class MailServiceImpl implements MailService{

    @Autowired
    MailDAO dao;
    @Override
    public int updateMailKey(MailDTO dto) {
        return dao.updateMailKey(dto);
    }

    @Override
    public int insertEmail(Map<String, String> map) {
        return dao.insertEmail(map);
    }

    @Override
    public int updateMailAuth(MailDTO dto) {
        return dao.updateMailAuth(dto);
    }

    @Override
    public int emailIsAuthFail(Map<String, String> map) {
        return dao.emailIsAuthFail(map);
    }
}
