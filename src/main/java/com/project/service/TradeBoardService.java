package com.project.service;

import java.util.List;

import com.project.model.TradeBoardAttachVO;
import com.project.model.TradeBoardVO;
import com.project.model.TradeCriteria;

public interface TradeBoardService {
//판매 게시판	
	//게시판 등록
	public void insert(TradeBoardVO board);

	//게시판 목록
	public List<TradeBoardVO> getList();
	
	//게시판 목록(페이징)
	public List<TradeBoardVO> getListPaging(TradeCriteria cri);
	
	//첨부파일 목록
	public List<TradeBoardAttachVO> getAttachList(Long bno);
	
	//게시판 조회
	public TradeBoardVO getPage(int tradeBno);
	
	//게시판 수정
	public boolean modify(TradeBoardVO board);
	
	//게시판 삭제
	public int delete(int tradeBno);
	
	//게시판 총 갯수
	public int getTotal(TradeCriteria cri);

	public boolean remove(Long bno);
	
	
//구매 게시판
	//게시판 등록
	public void insert2(TradeBoardVO board);

	//게시판 목록
	public List<TradeBoardVO> getList2();
	
	//게시판 목록(페이징)
	public List<TradeBoardVO> getListPaging2(TradeCriteria cri);
	
	//첨부파일 목록
	public List<TradeBoardAttachVO> getAttachList2(Long bno2);
	
	//게시판 조회
	public TradeBoardVO getPage2(int tradeBno2);
	
	//게시판 수정
	public boolean modify2(TradeBoardVO board);
	
	//게시판 삭제
	public int delete2(int tradeBno2);
	
	//게시판 총 갯수
	public int getTotal2(TradeCriteria cri);

	public boolean remove2(Long bno2);
	
//공지사항	
	//공지사항 등록
	public void insertNotice(TradeBoardVO board);

	//공지사항 목록
	public List<TradeBoardVO> getListNotice();
	
	//공지사항 목록(페이징)
	public List<TradeBoardVO> getListPagingNotice(TradeCriteria cri);
	
	//공지사항 조회
	public TradeBoardVO getPageNotice(int noticeBno);
	
	//공지사항 수정
	public boolean modifyNotice(TradeBoardVO board);
	
	//공지사항 삭제
	public int deleteNotice(int noticeBno);
	
	//공지사항 총 갯수
	public int getTotalNotice(TradeCriteria cri);
}
