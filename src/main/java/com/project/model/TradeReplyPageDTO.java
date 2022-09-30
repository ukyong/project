package com.project.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class TradeReplyPageDTO {
	private int replyCnt;
	private List<TradeReplyVO> list;
}
