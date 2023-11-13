package com.mail;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

public class MailHandler {

    private JavaMailSender mailSender;
    private MimeMessage mimeMessage;
    private MimeMessageHelper mimeMessageHelper;

    public MailHandler(JavaMailSender mailSender) throws MessagingException {
        this.mailSender = mailSender;
        mimeMessage = this.mailSender.createMimeMessage();
        mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
    }

    /**
     * 이메일 메세지의 제목을 지정하는 메서드
     * @param subject 메세지의 제목
     * @throws MessagingException
     */
    public void setSubject(String subject) throws MessagingException {
        mimeMessageHelper.setSubject(subject);
    }

    /**
     * 이메일 메세지의 본문을 지정하는 메서드
     * @param htmlContent 메세지의 본문(html 형식)
     * @throws MessagingException
     */
    public void setText(String htmlContent) throws MessagingException {
        mimeMessageHelper.setText(htmlContent, true);
    }

    /**
     * 이메일 메시지의 발신자를 설정하는 메서드
     * @param email 발신하는 이메일 주소
     * @param name 발신자의 이름
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    public void setFrom(String email, String name) throws MessagingException, UnsupportedEncodingException {
        mimeMessageHelper.setFrom(email, name);
    }

    /**
     * 이메일 메시지의 수신자를 설정하는 메서드
     * @param email 수신하는 이메일 주소
     * @throws MessagingException
     */
    public void setTo(String email) throws MessagingException {
        mimeMessageHelper.setTo(email);
    }

    /**
     * 이메일 메세지에 인라인 이미지나 첨부파일을 추가하는 메서드
     * @param contentId 리소스의 id값
     * @param dataSource 첨부할 데이터
     * @throws MessagingException
     */
    public void addInline(String contentId, DataSource dataSource) throws MessagingException {
        mimeMessageHelper.addInline(contentId, dataSource);
    }

    /**
     * 이메일 메세지를 보내는 메서드
     */
    public void send(){
        mailSender.send(mimeMessage);
    }
}
