package com.project.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TradeBoardVO {
//판매 게시판
	//게시글 번호
	private int tradeBno;
	//게시글 제목
	private String tradeTitle;
	//게시글 내용
	private String tradeContent;
	//게시글 작성자
	private String tradeWriter;
	//게시글 작성일자
	private Date tradeRegdate;
	//게시글 수정일자
	private Date tradeUpdatedate;
	//게시글 댓글 수
	private int tradeReplyCnt;
	//파일업로드
	private List<TradeBoardAttachVO> attachList;
	
//구매 게시판
	//게시글 번호
	private int tradeBno2;
	//게시글 제목
	private String tradeTitle2;
	//게시글 내용
	private String tradeContent2;
	//게시글 작성자
	private String tradeWriter2;
	//게시글 작성일자
	private Date tradeRegdate2;
	//게시글 수정일자
	private Date tradeUpdatedate2;
	//게시글 댓글 수
	private int tradeReplyCnt2;
	//파일업로드
	private List<TradeBoardAttachVO> attachList2;

//공지사항
	//게시글 번호
	private int noticeBno;
	//게시글 제목
	private String noticeTitle;
	//게시글 내용
	private String noticeContent;
	//게시글 작성자
	private String noticeWriter;
	//게시글 작성일자
	private Date noticeRegdate;
	//게시글 수정일자
	private Date noticeUpdatedate;
}
