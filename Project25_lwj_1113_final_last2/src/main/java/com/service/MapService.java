package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dto.MapDTO;
import com.dto.PageDTO;

public interface MapService {

    /**
     * API로부터 받아온 데이터를 DB에 저장하는 메서드
     * @param list API로부터 가져온 데이터
     * @return insert 성공 여부를 숫자로 반환
     */
    public int putApiData(List<MapDTO> list);
 
    public PageDTO findAll(int curPage, Map<String, String> location);

    public PageDTO findAllAdmin(int curPage, Map<String, String> location);

    public MapDTO findRetrieve(Map<String, String> map);

    public int insertData(MapDTO dto);

    public int deleteData(Map<String, String> map);

    public int updateData(MapDTO dto);
}
