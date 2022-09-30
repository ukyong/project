package com.project.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.model.TradeBoardAttachVO;
import com.project.model.TradeBoardVO;
import com.project.model.TradeCriteria;
import com.project.model.TradePageMakerDTO;
import com.project.service.TradeBoardService;

@Controller
@RequestMapping("/trade/*")
public class TradeController {
	
	@Autowired
	private TradeBoardService boardService;
	
//판매 페이지-----------------	
	//게시판 목록 페이지 접속(페이징 적용)
	@GetMapping("/list")
	public void boardListGET(Model model, TradeCriteria cri) {
		System.out.println("게시판 목록");
		
		model.addAttribute("list", boardService.getListPaging(cri));		
		
		int total = boardService.getTotal(cri);
		
		TradePageMakerDTO pageMake = new TradePageMakerDTO(cri, total);		
		
		model.addAttribute("pageMaker", pageMake);
	}
	
	
	//게시판등록 페이지 접속
	@GetMapping("/insert") 
	public void BoardInsertGet() {
		System.out.println("게시판 등록"); 
	}
		
	//게시판등록
	@PostMapping("/insert")
	public String BoardInsertPost(TradeBoardVO board, RedirectAttributes rttr) {
		System.out.println("게시판 등록 : " + board); 
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> System.out.println("" + attach));
		}
		
		boardService.insert(board);
		
		rttr.addFlashAttribute("result",board.getTradeBno());
		
		return "redirect:/trade/list";
	}
	
	//게시판 조회
	@GetMapping("/get")
	public void boardGetPageGET(int tradeBno, Model model, TradeCriteria cri) {
		model.addAttribute("pageInfo", boardService.getPage(tradeBno));
		
		model.addAttribute("cri", cri);
	}
	 
	//수정 페이지 이동
	@GetMapping("/modify")
	public void boardModifyGET(int tradeBno, Model model, TradeCriteria cri) {
		model.addAttribute("pageInfo", boardService.getPage(tradeBno));
		
		model.addAttribute("cri", cri);
	}
	

	/* 페이지 수정 */
	@PostMapping("/modify")
	public String boardModifyPOST(TradeBoardVO board, TradeCriteria cri, RedirectAttributes rttr) {
		
		boardService.modify(board);
		
		rttr.addFlashAttribute("result", "수정 성공");
		
		return "redirect:/trade/list" + cri.getListLink();
		
	}
	
	
	/* 첨부파일 조회 */
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<TradeBoardAttachVO>> getAttachList(Long bno){
		System.out.println("get attachList" + bno);
		return new ResponseEntity<>(boardService.getAttachList(bno), HttpStatus.OK);
	}
	
	/* 첨부파일 삭제 */
	@PostMapping("/remove")
	public String remove(@RequestParam("tradeBno") Long tradeBno, TradeCriteria cri, RedirectAttributes rttr) {
		System.out.println("remove....." + tradeBno);
		List<TradeBoardAttachVO> attachList = boardService.getAttachList(tradeBno);
		
		if(boardService.remove(tradeBno)) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/trade/list" + cri.getListLink();
	}
	
	/* 첨부파일 삭제 */
	@PostMapping("/delete")
	private void deleteFiles(List<TradeBoardAttachVO> attachList) {
		
		if(attachList==null || attachList.size()==0) {
			return;
		}
		
		System.out.println("첨부 파일 삭제.....");
		System.out.println(attachList);
		
		attachList.forEach(attach->{
			try {
				Path file=Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\"
					+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail=Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\s_"
							+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
				}				
			}catch(Exception e) {
				System.out.println("파일 삭제 에러:"+e.getMessage());
			}
		});
	}
//판매 페이지 끝-----------------
	
//구매 페이지-----------------	
	//게시판 목록 페이지 접속(페이징 적용)
	@GetMapping("/list2")
	public void boardListGET2(Model model, TradeCriteria cri) {
		System.out.println("게시판 목록2");
		model.addAttribute("list2", boardService.getListPaging2(cri));
		System.out.println("게시판 목록 22");
		int total = boardService.getTotal2(cri);
		System.out.println("22");
		TradePageMakerDTO pageMake = new TradePageMakerDTO(cri, total);
		System.out.println("33");
		model.addAttribute("pageMaker2", pageMake);
	}
	
	
	//게시판등록 페이지 접속
	@GetMapping("/insert2") 
	public void BoardInsertGet2() {
		System.out.println("게시판 등록2"); 
	}
		
	//게시판등록
	@PostMapping("/insert2")
	public String BoardInsertPost2(TradeBoardVO board, RedirectAttributes rttr) {
		System.out.println("게시판 등록 : " + board); 
		
		if(board.getAttachList2() != null) {
			board.getAttachList2().forEach(attach -> System.out.println("" + attach));
		}
		
		boardService.insert2(board);
		
		rttr.addFlashAttribute("result2",board.getTradeBno2());
		
		return "redirect:/trade/list2";
	}
	
	//게시판 조회
	@GetMapping("/get2")
	public void boardGetPageGET2(int tradeBno2, Model model, TradeCriteria cri) {
		System.out.println("1");
		model.addAttribute("pageInfo2", boardService.getPage2(tradeBno2));
		System.out.println("2");
		model.addAttribute("cri", cri);
	}
	 
	//수정 페이지 이동
	@GetMapping("/modify2")
	public void boardModifyGET2(int tradeBno2, Model model, TradeCriteria cri) {
		System.out.println("modify2");
		model.addAttribute("pageInfo2", boardService.getPage2(tradeBno2));
		System.out.println(boardService.getPage2(tradeBno2));
		model.addAttribute("cri", cri);
	}
	

	/* 페이지 수정 */
	@PostMapping("/modify2")
	public String boardModifyPOST2(TradeBoardVO board, RedirectAttributes rttr, TradeCriteria cri) {
		
		boardService.modify2(board);
		
		rttr.addFlashAttribute("result", "수정 성공2");
		
		return "redirect:/trade/list2" + cri.getListLink();
		
	}
	
	
	/* 첨부파일 조회 */
	@GetMapping(value = "/getAttachList2", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<TradeBoardAttachVO>> getAttachList2(Long bno2){
		System.out.println("get attachList2" + bno2);		
		return new ResponseEntity<>(boardService.getAttachList2(bno2), HttpStatus.OK);
	}
	
	/* 게시글 삭제 */
	@PostMapping("/remove2")
	public String remove2(@RequestParam("tradeBno2") Long tradeBno2, TradeCriteria cri, RedirectAttributes rttr) {
		System.out.println("remove....." + tradeBno2);
		List<TradeBoardAttachVO> attachList = boardService.getAttachList2(tradeBno2);
		
		if(boardService.remove2(tradeBno2)) {
			deleteFiles2(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/trade/list2" + cri.getListLink();
	}
	
	@PostMapping("/delete2")
	/* 첨부파일 삭제 */
	private void deleteFiles2(List<TradeBoardAttachVO> attachList2) {
		
		if(attachList2==null || attachList2.size()==0) {
			return;
		}
		
		System.out.println("첨부 파일 삭제2.....");
		System.out.println(attachList2);
		
		attachList2.forEach(attach->{
			try {
				Path file=Paths.get("c:\\upload2\\"+attach.getUploadPath2()+"\\"
					+attach.getUuid2()+"_"+attach.getFileName2());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail=Paths.get("c:\\upload2\\"+attach.getUploadPath2()+"\\s_"
							+attach.getUuid2()+"_"+attach.getFileName2());
					
					Files.delete(thumbNail);
				}				
			}catch(Exception e) {
				System.out.println("파일 삭제 에러:"+e.getMessage());
			}
		});
	}
//구매 페이지 끝-----------------
	
//공지사항
	//게시판 목록 페이지 접속(페이징 적용)
	@GetMapping("/notice")
	public void noticeListGET(Model model, TradeCriteria cri) {
		System.out.println("공지사항 목록");
		
		model.addAttribute("notice", boardService.getListPagingNotice(cri));
		
		int total = boardService.getTotalNotice(cri);
		
		TradePageMakerDTO pageMake = new TradePageMakerDTO(cri, total);
		System.out.println(pageMake);
		model.addAttribute("pageMaker3", pageMake);
	}
	
	
	//게시판등록 페이지 접속
	@GetMapping("/insertNotice") 
	public void noticeInsertGet() {
		System.out.println("공지사항 등록"); 
	}
		
	//게시판등록
	@PostMapping("/insertNotice")
	public String noticeInsertPost(TradeBoardVO board, RedirectAttributes rttr) {
		System.out.println("공지사항 등록 : " + board); 		
		
		boardService.insertNotice(board);
		
		rttr.addFlashAttribute("result",board.getNoticeBno());
		
		return "redirect:/trade/notice";
	}
	
	//게시판 조회
	@GetMapping("/getNotice")
	public void noticeGetPageGET(int noticeBno, Model model, TradeCriteria cri) {
		model.addAttribute("pageInfo3", boardService.getPageNotice(noticeBno));
		System.out.println("getnotice controller" + boardService.getPageNotice(noticeBno));
		model.addAttribute("cri", cri);
		System.out.println(cri);
	}
	 
	//수정 페이지 이동
	@GetMapping("/modifyNotice")
	public void noticeModifyGET(int noticeBno, Model model, TradeCriteria cri) {
		model.addAttribute("pageInfo3", boardService.getPageNotice(noticeBno));
		System.out.println("modifynotice controller" + boardService.getPageNotice(noticeBno));
		model.addAttribute("cri", cri);
	}
	

	/* 페이지 수정 */
	@PostMapping("/modifyNotice")
	public String noticeModifyPOST(TradeBoardVO board, RedirectAttributes rttr) {
		
		boardService.modifyNotice(board);
		
		rttr.addFlashAttribute("result", "수정 성공");
		
		return "redirect:/trade/notice";
		
	}
	
	//공지사항 삭제
	@PostMapping("/removeNotice")
	public String removeNotice(@RequestParam("noticeBno") int noticeBno, TradeCriteria cri, RedirectAttributes rttr) {
		System.out.println("remove....." + noticeBno);
		
		boardService.deleteNotice(noticeBno);
		rttr.addFlashAttribute("result", "success");
		return "redirect:/trade/notice" + cri.getListLink();
	}
			
}









