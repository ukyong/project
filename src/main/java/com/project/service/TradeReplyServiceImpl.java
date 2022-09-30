package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.mapper.TradeBoardMapper;
import com.project.mapper.TradeReplyMapper;
import com.project.model.TradeCriteria;
import com.project.model.TradeReplyPageDTO;
import com.project.model.TradeReplyPageDTO2;
import com.project.model.TradeReplyVO;

@Service
public class TradeReplyServiceImpl implements TradeReplyService{
//판매 게시판
	@Autowired
	private TradeReplyMapper mapper;
	
	@Autowired
	private TradeBoardMapper TradeBoardmapper;
	
	@Transactional
	@Override
	public int register(TradeReplyVO vo) {
		System.out.println("register...." + vo);
		TradeBoardmapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}

	@Override
	public TradeReplyVO get(Long rno) {
		System.out.println("get...." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(TradeReplyVO vo) {
		System.out.println("modify...." + vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		System.out.println("remove...." + rno);
		TradeReplyVO vo = mapper.read(rno);
		TradeBoardmapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public List<TradeReplyVO> getList(TradeCriteria cri, Long bno) {
		System.out.println("특정 게시물의 댓글 목록 리스트...." + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public TradeReplyPageDTO getListPage(TradeCriteria cri, Long bno) {
		return new TradeReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}
//구매 게시판 끝

//판매 게시판
	
	@Transactional
	@Override
	public int register2(TradeReplyVO vo) {
		System.out.println("register2...." + vo);
		TradeBoardmapper.updateReplyCnt2(vo.getBno2(), 1);
		return mapper.insert2(vo);
	}

	@Override
	public TradeReplyVO get2(Long rno2) {
		System.out.println("get2...." + rno2);
		return mapper.read2(rno2);
	}

	@Override
	public int modify2(TradeReplyVO vo) {
		System.out.println("modify2...." + vo);
		return mapper.update2(vo);
	}

	@Transactional
	@Override
	public int remove2(Long rno2) {
		System.out.println("remove2...." + rno2);
		TradeReplyVO vo = mapper.read2(rno2);
		TradeBoardmapper.updateReplyCnt2(vo.getBno2(), -1);
		return mapper.delete2(rno2);
	}

	@Override
	public List<TradeReplyVO> getList2(TradeCriteria cri, Long bno2) {
		System.out.println("특정 게시물의 댓글 목록 리스트2...." + bno2);
		return mapper.getListWithPaging2(cri, bno2);
	}

	@Override
	public TradeReplyPageDTO2 getListPage2(TradeCriteria cri, Long bno2) {
		return new TradeReplyPageDTO2(
				mapper.getCountByBno2(bno2),
				mapper.getListWithPaging2(cri, bno2));
	}

}
