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
    public int putApiData(List<MapDTO> list) {
        return dao.putApiData(list);
    }

	@Override
	public PageDTO findAll(int curPage, Map<String, String> location) {
		return dao.findAll(curPage, location);
	}

    @Override
    public PageDTO findAllAdmin(int curPage, Map<String, String> location) {
        return dao.findAllAdmin(curPage, location);
    }

    @Override
    public MapDTO findRetrieve(Map<String, String> map) {
        return dao.findRetrieve(map);
    }

    @Override
    public int insertData(MapDTO dto) {
        return dao.insertData(dto);
    }

    @Override
    public int deleteData(Map<String, String> map) {
        return dao.deleteData(map);
    }

    @Override
    public int updateData(MapDTO dto) {
        return dao.updateData(dto);
    }

}
