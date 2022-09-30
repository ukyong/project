package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.mapper.TradeBoardAttachMapper;
import com.project.mapper.TradeBoardMapper;
import com.project.mapper.TradeReplyMapper;
import com.project.model.TradeBoardAttachVO;
import com.project.model.TradeBoardVO;
import com.project.model.TradeCriteria;

@Service
public class TradeBoardServiceImpl implements TradeBoardService{
	@Autowired
	private TradeBoardMapper mapper;
	
	@Autowired
	private TradeBoardAttachMapper attachMapper;
	
	@Autowired
	private TradeReplyMapper TradeReplyMapper;
	
//판매 게시판
	@Transactional
	@Override
	public void insert(TradeBoardVO board) {
		System.out.println("등록: " + board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach ->{
			attach.setBno((long) board.getTradeBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public List<TradeBoardVO> getList() {
		return mapper.getList();
	}

	@Override
	public TradeBoardVO getPage(int tradeBno) {
		return mapper.getPage(tradeBno);
	}
	
	@Transactional
	@Override
	public boolean modify(TradeBoardVO board) {
		System.out.println("수정......" + board);
		
		attachMapper.deleteAll((long) board.getTradeBno());
		
		boolean modifyResult = mapper.modify(board) == 1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno((long) board.getTradeBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;		
	}
	
	@Override
	public int delete(int tradeBno) {
		return mapper.delete((long) tradeBno);
	}

	@Override
	public List<TradeBoardVO> getListPaging(TradeCriteria cri) {
		System.out.println("list1 getListPaging");
		return mapper.getListPaging(cri);
	}

	@Override
	public int getTotal(TradeCriteria cri) {
		return mapper.getTotal(cri);
	}

	@Override
	public List<TradeBoardAttachVO> getAttachList(Long bno) {
		System.out.println("해당 첨부파일 리스트 가져오기" + bno);
		
		return attachMapper.findByBno(bno);
	}
	
	@Transactional
	@Override
	public boolean remove(Long tradeBno) {
		attachMapper.deleteAll(tradeBno);
		System.out.println("remove....." + tradeBno);		
		TradeReplyMapper.deleteAll(tradeBno);
		System.out.println("댓글 삭제 ");
		System.out.println("remove attach");
		return mapper.delete(tradeBno)==1;
		
	}
	
//구매 게시판
	@Transactional
	@Override
	public void insert2(TradeBoardVO board) {
		System.out.println("등록2: " + board);
		mapper.insertSelectKey2(board);
		
		if(board.getAttachList2() == null || board.getAttachList2().size() <= 0) {
			return;
		}
		board.getAttachList2().forEach(attach ->{
			attach.setBno2((long) board.getTradeBno2());
			attachMapper.insert2(attach);
		});
	}

	@Override
	public List<TradeBoardVO> getList2() {
		return mapper.getList2();
	}

	@Override
	public TradeBoardVO getPage2(int tradeBno2) {
		return mapper.getPage2(tradeBno2);
	}
	
	@Transactional
	@Override
	public boolean modify2(TradeBoardVO board) {
		System.out.println("수정2......" + board);
		
		attachMapper.deleteAll2((long) board.getTradeBno2());
		
		boolean modifyResult = mapper.modify2(board) == 1;
		
		if(modifyResult && board.getAttachList2() != null && board.getAttachList2().size() > 0) {
			board.getAttachList2().forEach(attach -> {
				attach.setBno2((long) board.getTradeBno2());
				attachMapper.insert2(attach);
			});
		}
		return modifyResult;		
	}
	
	@Override
	public int delete2(int tradeBno2) {
		return mapper.delete2((long) tradeBno2);
	}

	@Override
	public List<TradeBoardVO> getListPaging2(TradeCriteria cri) {
		System.out.println("list2 getListPaging2");		
		return mapper.getListPaging2(cri);
		
	}

	@Override
	public int getTotal2(TradeCriteria cri) {
		return mapper.getTotal2(cri);
	}

	@Override
	public List<TradeBoardAttachVO> getAttachList2(Long bno2) {
		System.out.println("해당 첨부파일 리스트 가져오기2" + bno2);
		
		return attachMapper.findByBno2(bno2);
	}
	
	@Transactional
	@Override
	public boolean remove2(Long tradeBno2) {
		attachMapper.deleteAll2(tradeBno2);
		System.out.println("remove2....." + tradeBno2);		
		TradeReplyMapper.deleteAll2(tradeBno2);
		System.out.println("댓글 삭제2 ");
		System.out.println("remove attach2");
		return mapper.delete2(tradeBno2)==1;		
		
	}

	
//공지사항
	@Override
	public void insertNotice(TradeBoardVO board) {
		System.out.println("공지사항 등록");
		mapper.insertNotice(board);
	}


	@Override
	public List<TradeBoardVO> getListPagingNotice(TradeCriteria cri) {
		System.out.println("공지사항 페이징 조회");
		return mapper.getListPagingNotice(cri);
	}

	@Override
	public TradeBoardVO getPageNotice(int noticeBno) {
		return mapper.getPageNotice(noticeBno);
	}

	@Override
	public boolean modifyNotice(TradeBoardVO board) {
		System.out.println("공지사항 수정......" + board);
		
		boolean modifyResult = mapper.modifyNotice(board);
		
		return modifyResult;
	}

	@Override
	public int deleteNotice(int noticeBno) {		
		return mapper.deleteNotice(noticeBno);
	}

	@Override
	public int getTotalNotice(TradeCriteria cri) {
		return mapper.getTotalNotice(cri);
	}

	@Override
	public List<TradeBoardVO> getListNotice() {
		return mapper.getListNotice();
	}

}
