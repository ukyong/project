package com.project.model;

import lombok.Data;

@Data
public class BoardAttachVO {
	String uuid;		//난수
	String uploadPath;	//경로
	String fileName;	//파일이름
	boolean fileType;	//이미지 여부
	Long bno;
}
