package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.model.TradeBoardVO;
import com.project.model.TradeCriteria;

public interface TradeBoardMapper {
//판매 게시판
	//게시글 등록
	public void insert(TradeBoardVO board);
	
	public void insertSelectKey(TradeBoardVO board);
	
	//게시판 목록
	public List<TradeBoardVO> getList();
	
	//게시판 목록(페이징)
	public List<TradeBoardVO> getListPaging(TradeCriteria cri);
	
	//게시판 조회
	public TradeBoardVO getPage(int tradeBno);
	
	//게시판 수정
	public int modify(TradeBoardVO board);
	
	//게시판 삭제
	public int delete(Long tradeBno);
	
	//게시판 총 갯수
	public int getTotal(TradeCriteria cri);
	
	//게시판 제목에 댓글갯수
	public void updateReplyCnt(@Param("tradeBno")Long tradeBno, @Param("amount")int amount);

//구매 게시판
	//게시글 등록
	public void insert2(TradeBoardVO board);
	
	public void insertSelectKey2(TradeBoardVO board);
	
	//게시판 목록
	public List<TradeBoardVO> getList2();
	
	//게시판 목록(페이징)
	public List<TradeBoardVO> getListPaging2(TradeCriteria cri);
	
	//게시판 조회
	public TradeBoardVO getPage2(int tradeBno2);
	
	//게시판 수정
	public int modify2(TradeBoardVO board);
	
	//게시판 삭제
	public int delete2(Long tradeBno2);
	
	//게시판 총 갯수
	public int getTotal2(TradeCriteria cri);
	
	//게시판 제목에 댓글갯수
	public void updateReplyCnt2(@Param("tradeBno2")Long tradeBno2, @Param("amount")int amount);
	
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
