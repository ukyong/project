package com.project.mapper2;

import java.util.List;

import com.project.model.Criteria;
import com.project.model.pr_BoardVO;


public interface pr_BoardMapper {
	public pr_BoardVO read(Long bno);
	
	public void insertSelectKey(pr_BoardVO board);
	
	public int delete(Long bno);
	
	public int update(pr_BoardVO board);
	
	
	
	public List<pr_BoardVO> getListWithPaging_r(Criteria cri);
	public List<pr_BoardVO> getListWithPaging_c(Criteria cri);
	public List<pr_BoardVO> getListWithPaging_l(Criteria cri);
	public List<pr_BoardVO> getListWithPaging_b(Criteria cri);
	public List<pr_BoardVO> getListWithPaging_g(Criteria cri);
	
	
	
	public int getTotalCount_r(Criteria cri);
	public int getTotalCount_c(Criteria cri);
	public int getTotalCount_l(Criteria cri);
	public int getTotalCount_b(Criteria cri);
	public int getTotalCount_g(Criteria cri);
	
	
}
