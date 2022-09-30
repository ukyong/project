package com.project.model;

import lombok.Data;

@Data
public class AttachFileDTO {
	
	String fileName;	//파일이름
	String uploadPath;	//경로
	String uuid;		//난수
	boolean image;		//이미지 여부
}
