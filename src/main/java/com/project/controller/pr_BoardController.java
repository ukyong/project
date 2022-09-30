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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.model.BoardAttachVO;
import com.project.model.Criteria;
import com.project.model.PageDTO;
import com.project.model.pr_BoardVO;
import com.project.service2.pr_BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/pr_board/*")
@Log4j
public class pr_BoardController {

	@Autowired
	pr_BoardService service;
	
	
	@GetMapping("/list_r")
	public void list_r(Criteria cri,Model model) {	
		
		model.addAttribute("list",service.getList_r(cri));
		
		int total=service.getTotal_r(cri);
		
		PageDTO page=new PageDTO(cri,total);
		
		model.addAttribute("pageMaker",page);
	}
	@GetMapping("/list_c")
	public void list_c(Criteria cri,Model model) {	
		
		model.addAttribute("list",service.getList_c(cri));
		
		int total=service.getTotal_c(cri);
		
		PageDTO page=new PageDTO(cri,total);
		
		model.addAttribute("pageMaker",page);
	}
	@GetMapping("/list_l")
	public void list_l(Criteria cri,Model model) {	
		
		model.addAttribute("list",service.getList_l(cri));
		
		int total=service.getTotal_l(cri);
		
		PageDTO page=new PageDTO(cri,total);
		
		model.addAttribute("pageMaker",page);
	}
	@GetMapping("/list_b")
	public void list_b(Criteria cri,Model model) {	
		
		model.addAttribute("list",service.getList_b(cri));
		
		int total=service.getTotal_b(cri);
		
		PageDTO page=new PageDTO(cri,total);
		
		model.addAttribute("pageMaker",page);
	}
	
	@GetMapping("/list_g")
	public void list_g(Criteria cri,Model model) {	
		
		model.addAttribute("list",service.getList_g(cri));
		
		int total=service.getTotal_g(cri);
		
		PageDTO page=new PageDTO(cri,total);
		
		model.addAttribute("pageMaker",page);
	}
	
	
	
	@GetMapping("/register")
	public void register() {
		System.out.println("register get");
	}
	
	@PostMapping("/register")
	public String register(pr_BoardVO board,RedirectAttributes rttr) {
		System.out.println("register");
		
		if(board.getAttachList()!=null) {
			board.getAttachList().forEach(attach->log.info(attach));
		}
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		
		return "redirect:/pr_board/list_r";

	}
	
	@GetMapping({"/get","modify"})
	public void get(Long bno,@ModelAttribute("cri") Criteria cri,Model model) {
		model.addAttribute("board",service.get(bno));
	}
	
	
	  @PostMapping("/modify") 
	  public String modify(pr_BoardVO board,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
	  System.out.println("modify");
	  
	  if(service.modify(board)) { rttr.addFlashAttribute("result","success"); }
	  rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
	  
	  return "redirect:/pr_board/list_r"; }
	  
	  @PostMapping("/remove") 
	  public String remove(Long bno,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) { 
		  System.out.println("remove");
	  
		  List<BoardAttachVO> attachList=service.getAttachList(bno);
		  		 
	  if(service.remove(bno)) { deleteFiles(attachList); rttr.addFlashAttribute("result","success"); }
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
	  
	  return "redirect:/pr_board/list_r"+cri.getListLink(); }
	 
	  
	  @GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	  @ResponseBody
	  public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		  
		  return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
		  
	  }
	
	  
	  private void deleteFiles(List<BoardAttachVO> attachList) {
		  if(attachList == null || attachList.size()==0) {
			  return;
		  }
		  log.info("delete attach files............");
		  log.info(attachList);
		  
		  attachList.forEach(attach->{
			  try {
				  Path file=Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				  Files.deleteIfExists(file);
				  if(Files.probeContentType(file).startsWith("image")) {
					  Path thumbNail=Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					  Files.delete(thumbNail);
				  }
			  }catch(Exception e) {
				  log.error("delete file error"+e.getMessage());
			  }
		  });
	  }
}
