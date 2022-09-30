package com.project.model;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	int pageNum;	//페이지 번호
	int amount;		//페이지당 게시글 수
	
	String type;
	String keyword;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
	public String[] getTypeArr() {
		return type==null?new String[] {}:type.split("");
	}
	
	public String getListLink() {
		
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount",this.amount)
				.queryParam("type", this.type)
				.queryParam("keyword", this.keyword);
				
		return builder.toUriString();
				
	}
}
