package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MapDAO;
import com.dto.PageDTO;

@Service("service")
public class MapServiceImpl implements MapService {

	@Autowired
	MapDAO dao;

	@Override
	public PageDTO findAll(int curPage) {
		
		return dao.findAll(curPage);
	}



}
