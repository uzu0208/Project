package com.dao;

import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CPageDTO;
import com.dto.CommentDTO;

@Repository("CommentDAO")
public class CommentDAO {

    @Autowired
    SqlSessionTemplate session;

    public int insertComment(CommentDTO dto){
    	System.out.println(dto);
        return session.insert("CommentMapper.insertComment", dto);
    }
    
    public CPageDTO findAll(int c_curPage, Map<String, String> listkey) {
    	CPageDTO cdto = new CPageDTO();
    	
    	int offset = cdto.getC_perPage() * (c_curPage - 1);
		int limit = cdto.getC_perPage();
		int totalCount = session.selectOne("CommentMapper.counting",listkey);
		
		
    	cdto.setC_curPage(c_curPage);
    	cdto.setC_totalCount(totalCount);
    	cdto.setList(session.selectList("CommentMapper.findAll", listkey, new RowBounds(offset, limit)));
    	
    	return cdto;
    }
	 
}
