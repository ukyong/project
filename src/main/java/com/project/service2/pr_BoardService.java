package com.project.service2;

import java.util.List;

import com.project.model.BoardAttachVO;
import com.project.model.Criteria;
import com.project.model.pr_BoardVO;


public interface pr_BoardService {

	public void register(pr_BoardVO board);
	
	public pr_BoardVO get(Long bno);
	
	public boolean remove(Long bno);
	
	public boolean modify(pr_BoardVO board);
	
	public List<pr_BoardVO> getList_r(Criteria cri);
	public List<pr_BoardVO> getList_c(Criteria cri);
	public List<pr_BoardVO> getList_l(Criteria cri);
	public List<pr_BoardVO> getList_b(Criteria cri);
	public List<pr_BoardVO> getList_g(Criteria cri);	
	
	
	public int getTotal_r(Criteria cri);
	public int getTotal_c(Criteria cri);
	public int getTotal_l(Criteria cri);
	public int getTotal_b(Criteria cri);
	public int getTotal_g(Criteria cri);
	
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
	
}
