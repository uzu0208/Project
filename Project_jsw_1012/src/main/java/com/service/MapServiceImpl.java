package com.service;

import com.dao.MapDAO;
import com.dto.MapDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("MapService")
public class MapServiceImpl implements MapService{

    @Autowired
    MapDAO dao;

    @Override
    public List<MapDTO> findAll() {
        return dao.findAll();
    }

    @Transactional
    @Override
    public int loadApi(MapDTO dto) {
        dao.deleteAll();
        return dao.loadApi(dto);
    }
}
