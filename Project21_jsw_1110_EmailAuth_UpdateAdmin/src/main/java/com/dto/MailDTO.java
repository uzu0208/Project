package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("MailDTO")
public class MailDTO {

    String mailKey; // 이메일 인증번호
    String email1; // @전의 이메일 계정
    String email2; // @후의 이메일 주소

    public MailDTO() {
    }

    public MailDTO(String mailKey, String mailKeyExpiredDate, String email1, String email2) {
        this.mailKey = mailKey;
        this.email1 = email1;
        this.email2 = email2;
    }

    public String getMailKey() {
        return mailKey;
    }

    public void setMailKey(String mailKey) {
        this.mailKey = mailKey;
    }

    public String getEmail1() {
        return email1;
    }

    public void setEmail1(String email1) {
        this.email1 = email1;
    }

    public String getEmail2() {
        return email2;
    }

    public void setEmail2(String email2) {
        this.email2 = email2;
    }

    @Override
    public String toString() {
        return "MailDTO{" +
                "mailKey='" + mailKey + '\'' +
                ", email1='" + email1 + '\'' +
                ", email2='" + email2 + '\'' +
                '}';
    }
}
