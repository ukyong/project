package com.project.model;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageMakerDTO {

	//시작 페이지
	private int startPage;
	
	//끝 페이지
	private int endPage;
	
	// 이전페이지, 다음페이지 존재유무
	private boolean prev, next;
	
	//전체 게시물 수
	private int total;
	
	// 현제 페이지, 페이지당 게시물 표시수 정보
	private Criteria cri;
	
	//생성자
	public PageMakerDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		//마지막 페이지
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		
		//시작 페이지
		this.startPage = this.endPage-9;
		
		//전체 마지막 페이지
		int realEnd = (int)(Math.ceil(total*1.0/cri.getAmount()));
		
		//realEnd가 endPage보다 작은 경우
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		//시작 페이지 값이 1보다 큰 경우 true
		this.prev = this.startPage > 1;
		
		//마지막 페이지 값이 1보다 큰 경우 true
		this.next = this.endPage < realEnd;
		
		
	}

}
