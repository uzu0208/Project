package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MapDAO;
import com.dto.MapDTO;
import com.dto.PageDTO;

@Service("MapService")
public class MapServiceImpl implements MapService{

    @Autowired
    MapDAO dao;

    @Override
    public int loadApi(List<MapDTO> list) {
        return dao.loadApi(list);
    }

	@Override
	public PageDTO findAll(int curPage, Map<String, String> location) {
		return dao.findAll(curPage, location);
	}

}
