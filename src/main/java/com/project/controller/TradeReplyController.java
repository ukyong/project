package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.TradeCriteria;
import com.project.model.TradeReplyPageDTO;
import com.project.model.TradeReplyPageDTO2;
import com.project.model.TradeReplyVO;
import com.project.service.TradeReplyService;

import lombok.AllArgsConstructor;

@RequestMapping("/tradeReplies/")
@RestController
@AllArgsConstructor
public class TradeReplyController {
	@Autowired
	private TradeReplyService service;

//판매 게시판
	//댓글 등록
	@PostMapping(value="/new",
	consumes="application/json",
	produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody TradeReplyVO vo){
	System.out.println("TradeReplyVO:"+vo);
	
	int insertCount=service.register(vo);
	
	System.out.println("Reply 추가 갯수:"+insertCount);
	
	return insertCount==1
		?new ResponseEntity<>("success",HttpStatus.OK)
		:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	//특정 게시물의 댓글 목록 확인
	@GetMapping(value = "/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<TradeReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
		System.out.println("getList................");
		TradeCriteria cri = new TradeCriteria(page, 10);
		System.out.println(bno);
		System.out.println("controller cri" + cri);
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK);	
	}
	
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<TradeReplyVO> get(@PathVariable("rno") Long rno){
		System.out.println("get : " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	//댓글 삭제
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		System.out.println("remove : " + rno);
		return service.remove(rno) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody TradeReplyVO vo, @PathVariable("rno") Long rno){
		vo.setRno(rno);
		System.out.println("rno : " + rno);
		System.out.println("modify : " + vo);
		return service.modify(vo) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//구매 게시판
	//댓글 등록
	@PostMapping(value="/new2",
	consumes="application/json",
	produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create2(@RequestBody TradeReplyVO vo){
	System.out.println("ReplyVO:"+vo);
	
	int insertCount=service.register2(vo);
	
	System.out.println("Reply 추가 갯수:"+insertCount);
	
	return insertCount==1
		?new ResponseEntity<>("success",HttpStatus.OK)
		:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	//특정 게시물의 댓글 목록 확인
	@GetMapping(value = "/pages2/{bno2}/{page2}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<TradeReplyPageDTO2> getList2(@PathVariable("page2") int page, @PathVariable("bno2") Long bno2){
		System.out.println("getList2................");
		TradeCriteria cri = new TradeCriteria(page, 10);
		System.out.println(bno2);
		System.out.println("controller cri" + cri);
		return new ResponseEntity<>(service.getListPage2(cri, bno2),HttpStatus.OK);	
	}
	
	//댓글 조회
	@GetMapping(value = "/pages2/{rno2}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<TradeReplyVO> get2(@PathVariable("rno2") Long rno2){
		System.out.println("get : " + rno2);
		return new ResponseEntity<>(service.get2(rno2), HttpStatus.OK);
	}
	
	//댓글 삭제
	@DeleteMapping(value = "/delete/{rno2}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove2(@PathVariable("rno2") Long rno2){
		System.out.println("remove 2: " + rno2);
		return service.remove2(rno2) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/update2/{rno2}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify2(@RequestBody TradeReplyVO vo, @PathVariable("rno2") Long rno2){
		vo.setRno2(rno2);
		System.out.println("rno2 : " + rno2);
		System.out.println("modify : " + vo);
		return service.modify2(vo) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
}













