package com.project.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class pr_BoardVO {

	Long bno;
	String cgo,title,content,writer,front,map,address;
	Date regdate, updateDate;
	
	List<BoardAttachVO> attachList;
	
}
