package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dto.MapDTO;
import com.dto.PageDTO;

public interface MapService {

    public int loadApi(List<MapDTO> list);
 
    public PageDTO findAll(int curPage, Map<String, String> location);

    public PageDTO findAllAdmin(int curPage, Map<String, String> location);

    public MapDTO findRetrieve(Map<String, String> map);

    public int insertData(MapDTO dto);

    public int deleteData(Map<String, String> map);

    public int updateData(MapDTO dto);
}
