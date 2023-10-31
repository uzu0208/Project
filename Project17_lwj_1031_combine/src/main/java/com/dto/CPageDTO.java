package com.dto;

import java.util.List;
import java.util.Map;

public class CPageDTO {
	
	int c_curPage;
	int c_perPage = 3;
	int c_totalCount;
	List<CommentDTO> list;
	public CPageDTO() {
		// TODO Auto-generated constructor stub
	}
	public CPageDTO(int c_curPage, int c_perPage, int c_totalCount, List<CommentDTO> list) {
		this.c_curPage = c_curPage;
		this.c_perPage = c_perPage;
		this.c_totalCount = c_totalCount;
		this.list = list;
	}
	public int getC_curPage() {
		return c_curPage;
	}
	public void setC_curPage(int c_curPage) {
		this.c_curPage = c_curPage;
	}
	public int getC_perPage() {
		return c_perPage;
	}
	public void setC_perPage(int c_perPage) {
		this.c_perPage = c_perPage;
	}
	public int getC_totalCount() {
		return c_totalCount;
	}
	public void setC_totalCount(int c_totalCount) {
		this.c_totalCount = c_totalCount;
	}
	public List<CommentDTO> getList() {
		return list;
	}
	public void setList(List<CommentDTO> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "CPageDTO [c_curPage=" + c_curPage + ", c_perPage=" + c_perPage + ", c_totalCount=" + c_totalCount
				+ ", list=" + list + "]";
	}
}
