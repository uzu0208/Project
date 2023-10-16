package com.service;

import com.dao.MapDAO;
import com.dto.MapDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("MapService")
public class MapServiceImpl implements MapService{

    @Autowired
    MapDAO dao;

    @Override
    public int loadApi(MapDTO dto) {
        return dao.loadApi(dto);
    }
}
