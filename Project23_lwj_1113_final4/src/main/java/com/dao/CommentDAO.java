package com.dao;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
    
    public int deleteComment (String rno) {
    	return session.delete("CommentMapper.deleteComment", rno);
    }
    
    public CPageDTO findUserReply(int u_curPage, String userid) {
    		
    		CPageDTO cdto = new CPageDTO();
        	cdto.setC_perPage(10);
        	
        	int offset = cdto.getC_perPage() * (u_curPage - 1);
    		int limit = cdto.getC_perPage();
    		int totalCount = 0;
    		
    		if(userid != null) {
    			totalCount = session.selectOne("CommentMapper.userid_counting", userid);
    		}else {
    			totalCount = session.selectOne("CommentMapper.u_counting");
    		}
    	 
        	cdto.setC_curPage(u_curPage);
        	cdto.setC_totalCount(totalCount);
        	
        	if(userid != null) {
    			cdto.setList(session.selectList("CommentMapper.findUseridReply", userid , new RowBounds(offset, limit)));
    		}else {
    			cdto.setList(session.selectList("CommentMapper.findUserReply", null , new RowBounds(offset, limit)));
    		}
        	
        	return cdto;
    	
    }
    
    public CPageDTO findSelectedReply(int s_curPage, String contents, String option) {
    	
		CPageDTO cdto = new CPageDTO();
		cdto.setC_perPage(10);
		System.out.println("contents"+contents+contents+contents+contents+contents+contents+contents+contents+contents);
		
		Map<String,String> listkey = new HashMap<String, String>();
		listkey.put("contents", contents);
		listkey.put("option", option);
		
		int offset = cdto.getC_perPage() * (s_curPage - 1);
		int limit = cdto.getC_perPage();
		int totalCount = session.selectOne("CommentMapper.s_counting", listkey);
		
		System.out.println("totalCount"+totalCount);

		cdto.setC_curPage(s_curPage);
		cdto.setC_totalCount(totalCount);
		cdto.setList(session.selectList("CommentMapper.findSelectedReply", listkey, new RowBounds(offset, limit)));
		
		System.out.println("cdto"+cdto);

		return cdto;
	}
	 
}
