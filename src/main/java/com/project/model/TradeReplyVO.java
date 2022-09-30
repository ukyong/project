package com.project.model;

import java.util.Date;

import lombok.Data;

@Data
public class TradeReplyVO {
//판매 게시판	
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	
//구매 게시판	
	private Long rno2;
	private Long bno2;
	private String reply2;
	private String replyer2;
	private Date replyDate2;
	private Date updateDate2;
}
