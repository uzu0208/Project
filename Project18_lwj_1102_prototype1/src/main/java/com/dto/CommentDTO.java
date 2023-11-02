package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("CommentDTO")
public class CommentDTO {
	
	String rno; // 번호
	String fstvlNm; // 축제이름
	String opar; // 개최장소
	String fstvlStartDate; // 시작일자
	String fstvlEndDate; // 종료일자
	String writedate; // 쓴 날짜
	String comments; // 내용
	String rname; // 유저 이름
	String rid; // 유저 아이디
	 
	public CommentDTO(String rno, String fstvlNm, String opar, String fstvlStartDate, String fstvlEndDate,
			String writedate, String comments, String rname, String rid) {
		this.rno = rno;
		this.fstvlNm = fstvlNm;
		this.opar = opar;
		this.fstvlStartDate = fstvlStartDate;
		this.fstvlEndDate = fstvlEndDate;
		this.writedate = writedate;
		this.comments = comments;
		this.rname = rname;
		this.rid = rid;
	}

	public CommentDTO() {
		// TODO Auto-generated constructor stub
	}

	public CommentDTO( String fstvlNm, String opar, String fstvlStartDate, String fstvlEndDate,
			 String comments, String rid, String rname) {
		this.fstvlNm = fstvlNm;
		this.opar = opar;
		this.fstvlStartDate = fstvlStartDate;
		this.fstvlEndDate = fstvlEndDate;
		this.comments = comments;
		this.rid = rid;
		this.rname = rname;
	}

	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
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
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}

	@Override
	public String toString() {
		return "CommentDTO [rno=" + rno + ", fstvlNm=" + fstvlNm + ", opar=" + opar + ", fstvlStartDate="
				+ fstvlStartDate + ", fstvlEndDate=" + fstvlEndDate + ", writedate=" + writedate + ", comments="
				+ comments + ", rname=" + rname + ", rid=" + rid + "]";
	}
 
}
