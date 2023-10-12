package com.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MapDTO;
import com.dto.PageDTO;

@Repository("DAO")
public class MapDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	public PageDTO findAll(int curPage){
		
		PageDTO dto = new PageDTO();
		
		int offset = dto.getPerPage()*(curPage-1);
		int limit = dto.getPerPage();
		int totalCount = session.selectOne("Mapper.counting");
		
		List<MapDTO> list = session.selectList("Mapper.findAll", null, new RowBounds(offset, limit));
		
		dto.setCurPage(curPage);
		dto.setTotalCount(totalCount);
		dto.setList(list);

		return dto;
	}

}
