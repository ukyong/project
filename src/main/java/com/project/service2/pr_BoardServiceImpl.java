package com.project.service2;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.mapper2.pr_BoardAttachMapper;
import com.project.mapper2.pr_BoardMapper;
import com.project.model.BoardAttachVO;
import com.project.model.Criteria;
import com.project.model.pr_BoardVO;


@Service
public class pr_BoardServiceImpl implements pr_BoardService {

	@Autowired
	pr_BoardMapper mapper;
	
	@Autowired
	pr_BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(pr_BoardVO board) {
		
		mapper.insertSelectKey(board);
		if(board.getAttachList()==null || board.getAttachList().size()<=0) {
			return;
		}
		board.getAttachList().forEach(attach->{
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			
		});	
	}

	@Override
	public pr_BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		attachMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}
	
	@Transactional
	@Override
	public boolean modify(pr_BoardVO board) {
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
	public List<pr_BoardVO> getList_r(Criteria cri) {
		return mapper.getListWithPaging_r(cri);
	}
	@Override
	public List<pr_BoardVO> getList_c(Criteria cri) {
		return mapper.getListWithPaging_c(cri);
	}
	@Override
	public List<pr_BoardVO> getList_l(Criteria cri) {
		return mapper.getListWithPaging_l(cri);
	}
	@Override
	public List<pr_BoardVO> getList_b(Criteria cri) {
		return mapper.getListWithPaging_b(cri);
	}
	@Override
	public List<pr_BoardVO> getList_g(Criteria cri) {
		return mapper.getListWithPaging_g(cri);
	}

	

	@Override
	public int getTotal_r(Criteria cri) {
		return mapper.getTotalCount_r(cri);
	}
	@Override
	public int getTotal_c(Criteria cri) {
		return mapper.getTotalCount_c(cri);
	}
	@Override
	public int getTotal_l(Criteria cri) {
		return mapper.getTotalCount_l(cri);
	}
	@Override
	public int getTotal_b(Criteria cri) {
		return mapper.getTotalCount_b(cri);
	}
	@Override
	public int getTotal_g(Criteria cri) {
		return mapper.getTotalCount_g(cri);
	}

	

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}

}
