package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.model.BoardVO;
import com.project.model.Criteria;


public interface BoardMapper {
	
	public BoardVO read(Long bno);
	
	public List<BoardVO> getList();
	
	public void insertSelectKey(BoardVO board);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public List<BoardVO> getListWithPaging_f(Criteria cri);
	
	public List<BoardVO> getListWithPaging_h(Criteria cri);
	
	public List<BoardVO> getListWithPaging_i(Criteria cri);
	
	
	
	public int getTotalCount(Criteria cri);
	
	public int getTotalCount_f(Criteria cri);
	
	public int getTotalCount_h(Criteria cri);
	
	public int getTotalCount_i(Criteria cri);
	
	
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
