package com.project.mapper2;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.model.Criteria;
import com.project.model.ReplyVO;


public interface pr_ReplyMapper {
	public int insert(ReplyVO vo);
	public ReplyVO read(Long rno);
	public int delete(Long rno);
	public int update(ReplyVO reply);
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	public int getCountByBno(Long bno);
}
