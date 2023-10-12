package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MapDAO;
import com.dto.MapDTO;

@Service("service")
public class MapServiceImpl implements MapService {

	@Autowired
	MapDAO dao;

	@Override
	public List<MapDTO> findAll() {
		
		return dao.findAll();
	}



}
