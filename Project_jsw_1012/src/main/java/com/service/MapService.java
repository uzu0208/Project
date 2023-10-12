package com.service;

import com.dto.MapDTO;

import java.util.List;

public interface MapService {

    public List<MapDTO> findAll();
    public int loadApi(MapDTO dto);
}
