package com.project.mapper2;

import java.util.List;

import com.project.model.BoardAttachVO;


public interface pr_BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno);
	
	public List<BoardAttachVO> getOldFiles();
}
