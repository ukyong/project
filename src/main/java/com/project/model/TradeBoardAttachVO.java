package com.project.model;

import lombok.Data;

@Data
public class TradeBoardAttachVO {
//판매 게시판
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean filetype;
	private Long bno;
	
//구매 게시판
	private String uuid2;
	private String uploadPath2;
	private String fileName2;
	private boolean filetype2;
	private Long bno2;
}
