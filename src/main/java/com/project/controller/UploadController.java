package com.project.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.model.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		System.out.println("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile) {
		
		String uploadFolder="c:\\upload";
		
		for(MultipartFile multipartFile:uploadFile) {
			System.out.println("---------------");
			System.out.println("Upload 파일 이름:"+multipartFile.getOriginalFilename());
			System.out.println("Upload 파일 크기:"+multipartFile.getSize());
			
			File saveFile=new File(uploadFolder,multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}		
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		System.out.println("upload ajax");
	}
	
	@PostMapping(value="/uploadAjaxAction",
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjax(MultipartFile[] uploadFile) {
		
		System.out.println("ajax post......");
		
		//업로드 경로
		String uploadFolder="c:\\upload";
		
		//업로드 경로에 날짜 폴더 추가 만들기
		String uploadFolderPath=getFolder();
		
		//"c:\\upload\\2022\\09\\07"
		File uploadPath=new File(uploadFolder,uploadFolderPath);
		System.out.println("저장 경로:"+uploadPath);
		
		//해당 날짜 폴더 존재여부 확인
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		List<AttachFileDTO> list=new ArrayList<>();
		
		for(MultipartFile multipartFile:uploadFile) {
			System.out.println("---------------");
			System.out.println("Upload 파일 이름:"+multipartFile.getOriginalFilename());
			System.out.println("Upload 파일 크기:"+multipartFile.getSize());
			
			UUID uuid=UUID.randomUUID();
			String uploadFileName=multipartFile.getOriginalFilename();
			
			AttachFileDTO attachDTO=new AttachFileDTO();
			attachDTO.setFileName(uploadFileName);
			attachDTO.setUuid(uuid.toString());
			attachDTO.setUploadPath(uploadFolderPath);
			
			uploadFileName=uuid.toString()+"_"+uploadFileName;
			
			File saveFile=new File(uploadPath,uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);	//원본 파일 저장
				
				//이미지 파일이면 썸네일 파일 추가로 만들기
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					
					File saveFile2=new File(uploadPath,"s_"+uploadFileName);
					FileOutputStream thumbnail=new FileOutputStream(saveFile2);
					
					Thumbnailator.createThumbnail(
							multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				
				list.add(attachDTO);
				
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}//end for
		
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//썸네일 데이터 전송하기
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		System.out.println("파일이름:"+fileName);
		
		File file=new File("c:\\upload\\"+fileName);
		System.out.println("파일:"+file);
		
		ResponseEntity<byte[]> result=null;
		
		try {
			HttpHeaders header=new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result=new ResponseEntity<>(
					FileCopyUtils.copyToByteArray(file),
					header,HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}	
	
	//날짜 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date date=new Date();
		String str=sdf.format(date);
		
		//"2022-09-05" -> "2022\\09\\05"
		return str.replace("-", File.separator);
	}
	
	//이미지 파일 여부 확인
	private boolean checkImageType(File file) {
		try {
			String contentType=Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//파일 다운로드
	@GetMapping(value="/download",
			produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(
			@RequestHeader("User-Agent") String userAgent,String fileName){
		System.out.println("다운로드 파일:"+fileName);		
		Resource resource=new FileSystemResource("c:\\upload\\"+fileName);
		
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		System.out.println("리소스:"+resource);		
		String resourceName=resource.getFilename();
		
		String resourceOriginalName=resourceName.substring(
				resourceName.indexOf("_")+1);
		
		HttpHeaders headers=new HttpHeaders();
		try {
			String downloadName=null;
			
			if(userAgent.contains("Edge")) {
				System.out.println("Edge 브라우저");
				downloadName=URLEncoder.encode(resourceOriginalName,"utf-8");
				System.out.println("Edge 이름:"+downloadName);
			}else {
				System.out.println("Chrome 브라우저");
				downloadName=new String(resourceOriginalName.getBytes("utf-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", 
					"attachment; filename="+downloadName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName,String type){
		System.out.println("삭제파일:"+fileName);
				
		try {
			File file=new File("c:\\upload\\"+URLDecoder.decode(fileName,"utf-8"));
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName=file.getAbsolutePath().replace("s_", "");
				System.out.println("큰 파일 이름:"+largeFileName);
				file=new File(largeFileName);
				
				file.delete();
			}
		}catch(Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
}


