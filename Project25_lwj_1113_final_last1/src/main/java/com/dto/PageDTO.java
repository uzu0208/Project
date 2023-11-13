package com.dto;

import java.util.List;
import java.util.Map;

public class PageDTO {
	
	int curPage;
	int perPage = 8;
	int totalCount;
	List<MapDTO> list;
	Map<String,String> location;
	public PageDTO() {
		// TODO Auto-generated constructor stub
	}
	public PageDTO(int curPage, int perPage, int totalCount, List<MapDTO> list, Map<String,String> location) {
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
		this.list = list;
		this.location = location;
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
	public Map<String, String> getLocation() {
		return location;
	}
	public void setLocation(Map<String, String> location) {
		this.location = location;
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
				+ ", location=" + location + "]";
	}
}
