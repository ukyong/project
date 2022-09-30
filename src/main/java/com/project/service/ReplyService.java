package com.project.service;

import java.util.List;

import com.project.model.Criteria;
import com.project.model.ReplyPageDTO;
import com.project.model.ReplyVO;


public interface ReplyService {

	int register(ReplyVO vo);
	
	ReplyVO get(Long rno);
	
	int modify(ReplyVO vo);
	
	int remove(Long rno);
	
	List<ReplyVO> getList(Criteria cri,Long bno);
	
	ReplyPageDTO getListPage(Criteria cri,Long bno);
	
	int getCount(Long bno);
	
}
