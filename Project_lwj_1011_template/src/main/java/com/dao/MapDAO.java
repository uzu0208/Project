package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MapDTO;

@Repository("DAO")
public class MapDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<MapDTO> findAll(){
		return session.selectList("Mapper.findAll");
	}

}
