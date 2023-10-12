package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("MapDTO")
public class MapDTO {
	
	int deptno;
	String dname;
	String loc;
	
	public MapDTO() {
		// TODO Auto-generated constructor stub
	}
	public MapDTO(int deptno, String dname, String loc) {
		this.deptno = deptno;
		this.dname = dname;
		this.loc = loc;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	@Override
	public String toString() {
		return "MapDTO [deptno=" + deptno + ", dname=" + dname + ", loc=" + loc + "]";
	}
}
