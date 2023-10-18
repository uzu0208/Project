package com.service;

import java.util.List;

import com.dto.MapDTO;
import com.dto.PageDTO;

public interface MapService {

    public int loadApi(MapDTO dto);
 
    public PageDTO findAll(int curPage, String location);
}
