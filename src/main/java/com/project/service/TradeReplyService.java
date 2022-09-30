package com.project.service;

import java.util.List;

import com.project.model.TradeCriteria;
import com.project.model.TradeReplyPageDTO;
import com.project.model.TradeReplyPageDTO2;
import com.project.model.TradeReplyVO;

public interface TradeReplyService {
//판매 게시판
	public int register(TradeReplyVO vo);
	
	public TradeReplyVO get(Long rno);
	
	public int modify(TradeReplyVO vo);
	
	public int remove(Long rno);
	
	public List<TradeReplyVO> getList(TradeCriteria cri, Long bno);
	
	public TradeReplyPageDTO getListPage(TradeCriteria cri, Long bno);
	
//구매 게시판
	public int register2(TradeReplyVO vo);
	
	public TradeReplyVO get2(Long rno2);
	
	public int modify2(TradeReplyVO vo);
	
	public int remove2(Long rno2);
	
	public List<TradeReplyVO> getList2(TradeCriteria cri, Long bno2);
	
	public TradeReplyPageDTO2 getListPage2(TradeCriteria cri, Long bno2);
}
