package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("MapDTO")
public class MapDTO {

    String fstvlNm; // 축제명
    String opar; // 개최장소
    String fstvlStartDate; // 축제시작일자
    String fstvlEndDate; // 축제종료일자
    String fstvlCo; // 축제내용
    String mnnst; // 주관기관
    String auspcInstt; // 주최기관
    String suprtInstt; // 후원기관
    String phoneNumber; // 전화번호
    String homepageUrl; // 홈페이지주소
    String relateInfo; // 관련정보
    String rdnmadr; // 소재지도로명주소
    String lnmadr; // 소재지지번주소
    String latitude; // 위도
    String longitude; // 경도
    String referenceDate; // 데이터기준일자
    String insttCode; // 제공기관코드

    public MapDTO() {
    }

    public MapDTO(String fstvlNm, String opar, String fstvlStartDate, String fstvlEndDate, String fstvlCo, String mnnst,
                  String auspcInstt, String suprtInstt, String phoneNumber, String homepageUrl, String relateInfo,
                  String rdnmadr, String lnmadr, String latitude, String longitude, String referenceDate, String insttCode) {
        this.fstvlNm = fstvlNm;
        this.opar = opar;
        this.fstvlStartDate = fstvlStartDate;
        this.fstvlEndDate = fstvlEndDate;
        this.fstvlCo = fstvlCo;
        this.mnnst = mnnst;
        this.auspcInstt = auspcInstt;
        this.suprtInstt = suprtInstt;
        this.phoneNumber = phoneNumber;
        this.homepageUrl = homepageUrl;
        this.relateInfo = relateInfo;
        this.rdnmadr = rdnmadr;
        this.lnmadr = lnmadr;
        this.latitude = latitude;
        this.longitude = longitude;
        this.referenceDate = referenceDate;
        this.insttCode = insttCode;
    }

    public String getFstvlNm() {
        return fstvlNm;
    }

    public void setFstvlNm(String fstvlNm) {
        this.fstvlNm = fstvlNm;
    }

    public String getOpar() {
        return opar;
    }

    public void setOpar(String opar) {
        this.opar = opar;
    }

    public String getFstvlStartDate() {
        return fstvlStartDate;
    }

    public void setFstvlStartDate(String fstvlStartDate) {
        this.fstvlStartDate = fstvlStartDate;
    }

    public String getFstvlEndDate() {
        return fstvlEndDate;
    }

    public void setFstvlEndDate(String fstvlEndDate) {
        this.fstvlEndDate = fstvlEndDate;
    }

    public String getFstvlCo() {
        return fstvlCo;
    }

    public void setFstvlCo(String fstvlCo) {
        this.fstvlCo = fstvlCo;
    }

    public String getMnnst() {
        return mnnst;
    }

    public void setMnnst(String mnnst) {
        this.mnnst = mnnst;
    }

    public String getAuspcInstt() {
        return auspcInstt;
    }

    public void setAuspcInstt(String auspcInstt) {
        this.auspcInstt = auspcInstt;
    }

    public String getSuprtInstt() {
        return suprtInstt;
    }

    public void setSuprtInstt(String suprtInstt) {
        this.suprtInstt = suprtInstt;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getHomepageUrl() {
        return homepageUrl;
    }

    public void setHomepageUrl(String homepageUrl) {
        this.homepageUrl = homepageUrl;
    }

    public String getRelateInfo() {
        return relateInfo;
    }

    public void setRelateInfo(String relateInfo) {
        this.relateInfo = relateInfo;
    }

    public String getRdnmadr() {
        return rdnmadr;
    }

    public void setRdnmadr(String rdnmadr) {
        this.rdnmadr = rdnmadr;
    }

    public String getLnmadr() {
        return lnmadr;
    }

    public void setLnmadr(String lnmadr) {
        this.lnmadr = lnmadr;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getReferenceDate() {
        return referenceDate;
    }

    public void setReferenceDate(String referenceDate) {
        this.referenceDate = referenceDate;
    }

    public String getInsttCode() {
        return insttCode;
    }

    public void setInsttCode(String insttCode) {
        this.insttCode = insttCode;
    }

    @Override
    public String toString() {
        return "MapDTO{" +
                "fstvlNm='" + fstvlNm + '\'' +
                ", opar='" + opar + '\'' +
                ", fstvlStartDate='" + fstvlStartDate + '\'' +
                ", fstvlEndDate='" + fstvlEndDate + '\'' +
                ", fstvlCo='" + fstvlCo + '\'' +
                ", mnnst='" + mnnst + '\'' +
                ", auspcInstt='" + auspcInstt + '\'' +
                ", suprtInstt='" + suprtInstt + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", homepageUrl='" + homepageUrl + '\'' +
                ", relateInfo='" + relateInfo + '\'' +
                ", rdnmadr='" + rdnmadr + '\'' +
                ", lnmadr='" + lnmadr + '\'' +
                ", latitude='" + latitude + '\'' +
                ", longitude='" + longitude + '\'' +
                ", referenceDate='" + referenceDate + '\'' +
                ", insttCode='" + insttCode + '\'' +
                '}';
    }
}
