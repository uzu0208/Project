package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("MemberDTO")
public class MemberDTO {

    String userid; // 아이디
    String password; // 비밀번호
    String username; // 이름
    String post; // 우편번호
    String addr1; // 도로명주소
    String addr2; // 지번주소
    String phone1; // 휴대전화번호(010, 011)
    String phone2; // 휴대전화번호 (중간)
    String phone3; // 휴대전화번호 (마지막)
    String email1; // 이메일(아이디)
    String email2; // 이메일(주소)
    String isAdmin; // 관리자 계정 확인
    String mailKey; // 이메일 인증키


    public MemberDTO() {
    }

    public MemberDTO(String userid, String password, String username, String post, String addr1, String addr2,
                     String phone1, String phone2, String phone3, String email1, String email2, String isAdmin,
                     String mailKey) {
        this.userid = userid;
        this.password = password;
        this.username = username;
        this.post = post;
        this.addr1 = addr1;
        this.addr2 = addr2;
        this.phone1 = phone1;
        this.phone2 = phone2;
        this.phone3 = phone3;
        this.email1 = email1;
        this.email2 = email2;
        this.isAdmin = isAdmin;
        this.mailKey = mailKey;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getAddr2() {
        return addr2;
    }

    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }

    public String getPhone1() {
        return phone1;
    }

    public void setPhone1(String phone1) {
        this.phone1 = phone1;
    }

    public String getPhone2() {
        return phone2;
    }

    public void setPhone2(String phone2) {
        this.phone2 = phone2;
    }

    public String getPhone3() {
        return phone3;
    }

    public void setPhone3(String phone3) {
        this.phone3 = phone3;
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

    public String getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getMailKey() {
        return mailKey;
    }

    public void setMailKey(String mailKey) {
        this.mailKey = mailKey;
    }

    @Override
    public String toString() {
        return "MemberDTO{" +
                "userid='" + userid + '\'' +
                ", password='" + password + '\'' +
                ", username='" + username + '\'' +
                ", post='" + post + '\'' +
                ", addr1='" + addr1 + '\'' +
                ", addr2='" + addr2 + '\'' +
                ", phone1='" + phone1 + '\'' +
                ", phone2='" + phone2 + '\'' +
                ", phone3='" + phone3 + '\'' +
                ", email1='" + email1 + '\'' +
                ", email2='" + email2 + '\'' +
                ", isAdmin='" + isAdmin + '\'' +
                ", mailKey='" + mailKey + '\'' +
                '}';
    }
}
