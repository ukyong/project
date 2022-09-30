package com.project.mapper;

import java.util.List;

import com.project.model.TradeBoardAttachVO;

public interface TradeBoardAttachMapper {
//판매 게시판
	//첨부파일 등록
	public void insert(TradeBoardAttachVO vo);
	
	//첨부파일 삭제
	public void delete(String uuid);
	
	//첨부파일 조회
	public List<TradeBoardAttachVO> findByBno(Long bno);
	
	//게시글과 첨부파일 삭제
	public void deleteAll(Long tradeBno);
	
	//DB확인후 불일치시 파일 삭제
	public List<TradeBoardAttachVO> getOldFiles();
	
//구매 게시판
	//첨부파일 등록
	public void insert2(TradeBoardAttachVO vo);
	
	//첨부파일 삭제
	public void delete2(String uuid2);
	
	//첨부파일 조회
	public List<TradeBoardAttachVO> findByBno2(Long bno2);
	
	//게시글과 첨부파일 삭제
	public void deleteAll2(Long tradeBno2);
	
	//DB확인후 불일치시 파일 삭제
	public List<TradeBoardAttachVO> getOldFiles2();

}
