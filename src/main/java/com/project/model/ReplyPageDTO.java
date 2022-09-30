package com.project.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReplyPageDTO {
	
	int replyCnt;
	List<ReplyVO> list;
	
}
