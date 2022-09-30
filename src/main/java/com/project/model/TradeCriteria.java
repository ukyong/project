package com.project.model;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.ToString;

@ToString
public class TradeCriteria {

	//현재 페이지
	private int pageNum;
	
	//한 페이지당 보여질 게시물 갯수
	private int amount;
	
	//검색 키워드
	private String keyword;
	
	//검색 타입
	private String type;
	
	//스킵할 게시물 수( (pageNum-1)*amount)
	private int skip;
	
	//getListLink
	public String getListLink() {
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount",this.amount)
				.queryParam("type", this.type)
				.queryParam("keyword", this.keyword);				
				
		return builder.toUriString();
	}
	
	
	//기본 생성자 -> 기본세팅 : pageNum = 1, amount = 10
	public TradeCriteria() {
		this(1,10);
		this.skip = 0;
	}
	
	//생성자
	public TradeCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.skip = (pageNum-1)*amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.skip = (pageNum-1)*this.amount;
		
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.skip = (this.pageNum-1)*amount;
		
		this.amount = amount;
	}

	public int getSkip() {
		return skip;
	}

	public void setSkip(int skip) {
		this.skip = skip;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String[] getTypeArr() {
		return type==null?new String[] {}:type.split("");
	}
	

}
