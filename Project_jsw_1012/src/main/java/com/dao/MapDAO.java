package com.dao;

import com.dto.MapDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("MapDAO")
public class MapDAO {

    @Autowired
    SqlSessionTemplate session;

    public List<MapDTO> findAll(){
        return session.selectList("MapMapper.findAll");
    }

    public int deleteAll(){
        return session.delete("MapMapper.deleteAll");
    }

    public int loadApi(MapDTO dto){
        return session.insert("MapMapper.loadApi", dto);
    }
}
