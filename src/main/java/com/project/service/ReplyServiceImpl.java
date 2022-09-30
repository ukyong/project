package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.mapper.BoardMapper;
import com.project.mapper.ReplyMapper;
import com.project.model.Criteria;
import com.project.model.ReplyPageDTO;
import com.project.model.ReplyVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	ReplyMapper mapper;
	@Autowired
	BoardMapper boardmapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		System.out.println("register....."+vo);
		
		boardmapper.updateReplyCnt(vo.getBno(),1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		System.out.println("get......"+rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		System.out.println("modify....."+vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		System.out.println("remove....."+rno);
		
		ReplyVO vo=mapper.read(rno);
		
		boardmapper.updateReplyCnt(vo.getBno(),-1);
		
		return mapper.delete(rno);		
	}
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		System.out.println("get Reply List "+bno);
		
		return mapper.getListWithPaging(cri, bno);		
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		int cnt=mapper.getCountByBno(bno);
		List<ReplyVO> list=mapper.getListWithPaging(cri, bno);
		
		return new ReplyPageDTO(cnt,list);
	}

	@Override
	public int getCount(Long bno) {
		int cnt=mapper.getCountByBno(bno);
		return cnt;
	}
	
	
}
