package com.project.model;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	int startPage;		//시작페이지
	int endPage;		//끝페이지
	boolean prev,next;	//이전,다음 여부
	
	int total;			//게시글 전체갯수
	Criteria cri;		//페이지 번호,페이지당 갯수
	
	public PageDTO(Criteria cri,int total) {
		this.cri=cri;
		this.total=total;
		
		this.endPage=(int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.startPage=this.endPage-9;
		
		int realEnd=(int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		if(realEnd<this.endPage) {
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage>1;
		this.next=this.endPage<realEnd;
	}
}
