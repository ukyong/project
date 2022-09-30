package com.project.model;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	Long rno;
	Long bno;
	String reply;
	String replyer;
	Date replyDate;
	Date updateDate;
}
