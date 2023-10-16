package com.dao;

import com.dto.MapDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("MapDAO")
public class MapDAO {

    @Autowired
    SqlSessionTemplate session;


    public int loadApi(MapDTO dto){
        return session.update("MapMapper.loadApi", dto);
    }
}
