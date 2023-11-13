package com.mail;

import java.security.SecureRandom;

public class GenerateKey {

    private int size;

    public String getKey(int size){
        this.size = size;
        return initialize();
    }

    private String initialize() {

        SecureRandom random = new SecureRandom();
        StringBuilder stringBuilder = new StringBuilder();
        int num;

        do {
            num = random.nextInt(75) + 48;
            // 0 ~ 9 또는 대문자 영어 또는 소문자 영어를 조합
            if (num <= 57 || (num >= 65 && num <= 90) || num >= 97){
                stringBuilder.append((char) num);
            }
        }while (stringBuilder.length() < size);

        return stringBuilder.toString();
    }
}
