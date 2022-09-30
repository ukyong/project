package com.project.service;

import java.util.List;

import com.project.model.BoardAttachVO;
import com.project.model.BoardVO;
import com.project.model.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean remove(Long bno);
	
	public boolean modify(BoardVO board);
	
	
	public List<BoardVO> getList(Criteria cri);
	
	public List<BoardVO> getList_f(Criteria cri);
	
	public List<BoardVO> getList_h(Criteria cri);
	
	public List<BoardVO> getList_i(Criteria cri);
	
	
	public int getTotal(Criteria cri);
	
	public int getTotal_f(Criteria cri);
	
	public int getTotal_h(Criteria cri);
	
	public int getTotal_i(Criteria cri);
	
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
}
