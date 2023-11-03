package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MapDTO;
import com.dto.PageDTO;

@Repository("MapDAO")
public class MapDAO {

    @Autowired
    SqlSessionTemplate session;


    public int loadApi(List<MapDTO> list){
        return session.update("MapMapper.loadApi", list);
    }

	
	public PageDTO findAll(int curPage, Map<String, String> location) {

		PageDTO dto = new PageDTO();

		int offset = dto.getPerPage() * (curPage - 1);
		int limit = dto.getPerPage();
		int totalCount = session.selectOne("MapMapper.counting",location);

		List<MapDTO> list = session.selectList("MapMapper.findAll", location, new RowBounds(offset, limit));

		dto.setCurPage(curPage);
		dto.setTotalCount(totalCount);
		dto.setList(list);
		dto.setLocation(location);

		return dto;
	}

	public PageDTO findAllAdmin(int curPage, Map<String, String> location){

		PageDTO dto = new PageDTO();

		int offset = dto.getPerPage() * (curPage - 1);
		int limit = dto.getPerPage();
		int totalCount = session.selectOne("MapMapper.countingAdmin", location);

		List<MapDTO> list = session.selectList("MapMapper.findAllAdmin", location, new RowBounds(offset, limit));

		dto.setCurPage(curPage);
		dto.setTotalCount(totalCount);
		dto.setList(list);
		dto.setLocation(location);

		return dto;
	}

	public MapDTO findRetrieve(Map<String, String> map){
		return session.selectOne("MapMapper.findRetrieve", map);
	}

	public int insertData(MapDTO dto){
		return session.insert("MapMapper.insertData", dto);
	}

	public int deleteData(Map<String, String> map){
		return session.delete("MapMapper.deleteData", map);
	}

	public int updateData(MapDTO dto){
		return session.update("MapMapper.updateData", dto);
	}
}
