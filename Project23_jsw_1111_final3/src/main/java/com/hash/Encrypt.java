package com.hash;

public interface Encrypt {

    /**
     * 비밀번호를 암호화하는 메서드
     * @param password 암호화할 비밀번호
     * @return 암호화한 비밀번호
     */
    public String encrypt(String password);

    /**
     * 비밀번호가 맞는지 확인하는 메서드
     * @param password 비밀번호(평문)
     * @param hashedPassword 비밀번호(암호화)
     * @return 맞는 지에 대해 boolean 타입 반환
     */
    public boolean isMatchPassword(String password, String hashedPassword);
}
