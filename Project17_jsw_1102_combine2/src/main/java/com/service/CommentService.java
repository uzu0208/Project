package com.service;

import java.util.Map;

import com.dto.CPageDTO;
import com.dto.CommentDTO;

public interface CommentService {
	public int insertComment (CommentDTO dto);
	public CPageDTO findAll(int c_curPage, Map<String, String> listkey);
}
