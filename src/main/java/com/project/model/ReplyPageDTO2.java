package com.project.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO2 {
	private int replyCnt2;
	private List<ReplyVO> list2;
}
