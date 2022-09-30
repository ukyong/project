package com.project.model;

import lombok.Data;

@Data
public class TradeAttachFileDTO {
//판매 게시판
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
//구매 게시판
	private String fileName2;
	private String uploadPath2;
	private String uuid2;
	private boolean image2;
}
