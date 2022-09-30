package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.mapper.BoardAttachMapper;
import com.project.mapper.BoardMapper;
import com.project.model.BoardAttachVO;
import com.project.model.BoardVO;
import com.project.model.Criteria;


@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper mapper;
	
	@Autowired
	BoardAttachMapper attachMapper;
	
	@Override
	public BoardVO get(Long bno) {
		
		return mapper.read(bno);
		
	}
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		
		mapper.insertSelectKey(board);
		if(board.getAttachList()==null || board.getAttachList().size()<=0) {
			return;
		}
		board.getAttachList().forEach(attach->{
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			
		});
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		
		attachMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
		
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		System.out.println("modify....."+board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult=mapper.update(board)==1;
		
		if(modifyResult && board.getAttachList()!=null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}


	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
		
	}
	
	@Override
	public List<BoardVO> getList_f(Criteria cri) {
		return mapper.getListWithPaging_f(cri);
	}

	@Override
	public List<BoardVO> getList_h(Criteria cri) {
		return mapper.getListWithPaging_h(cri);
	}

	@Override
	public List<BoardVO> getList_i(Criteria cri) {
		return mapper.getListWithPaging_i(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		
		return attachMapper.findByBno(bno);
		
	}
	

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public int getTotal_f(Criteria cri) {
		return mapper.getTotalCount_f(cri);
	}

	@Override
	public int getTotal_h(Criteria cri) {
		return mapper.getTotalCount_h(cri);
	}

	@Override
	public int getTotal_i(Criteria cri) {
		return mapper.getTotalCount_i(cri);
	}


}
