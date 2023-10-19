package com.dto;

import java.util.List;

public class PageDTO {
	
	int curPage;
	int perPage = 10;
	int totalCount;
	List<MapDTO> list;
	public PageDTO() {
		// TODO Auto-generated constructor stub
	}
	public PageDTO(int curPage, int perPage, int totalCount, List<MapDTO> list) {
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
		this.list = list;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public List<MapDTO> getList() {
		return list;
	}
	public void setList(List<MapDTO> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "PageDTO [curPage=" + curPage + ", perPage=" + perPage + ", totalCount=" + totalCount + ", list=" + list
				+ "]";
	}
}
