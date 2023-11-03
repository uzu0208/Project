package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.CommentDAO;
import com.dto.CPageDTO;
import com.dto.CommentDTO;

@Service("CommentService")
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentDAO dao;

	@Override
	public int insertComment(CommentDTO dto) {
		 
		return dao.insertComment(dto);
	}

	@Override
	public CPageDTO findAll(int c_curPage, Map<String, String> listkey) {
		return dao.findAll(c_curPage, listkey);
	}

	@Override
	public int deleteComment(String rno) {
		return dao.deleteComment(rno);
	}

}
