package com.project.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.mapper.TradeBoardAttachMapper;
import com.project.model.TradeBoardAttachVO;

@Component
public class FileCheckTask {
	
	@Autowired
	private TradeBoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return null;		
	}
	
	@Scheduled(cron="0 0 10 * * *")
	public void checkFiles() throws Exception{
		System.out.println("파일 체크 작업 시작.....");
		System.out.println("===================");
		
		List<TradeBoardAttachVO> fileList=attachMapper.getOldFiles();
		
		//DB내용을 파일경로명 변경
		List<Path> fileListPaths=
				fileList.stream()
				.map(vo->Paths.get("c:\\upload",
						vo.getUploadPath(),
						vo.getUuid()+"_"+vo.getFileName()))
				.collect(Collectors.toList());
		
		//이미지이면 DB내용을 썸네일파일 경로명 추가
		fileList.stream().filter(vo->vo.isFiletype()==true)
		.map(vo->Paths.get("c:\\upload",
				vo.getUploadPath(),
				"s_"+vo.getUuid()+"_"+vo.getFileName()))
		.forEach(p->fileListPaths.add(p));
		
		System.out.println("===================");
		
		//DB파일명 -> 실제 파일경로명 확인
		fileListPaths.forEach(p->System.out.println(p));
		
		File targetDir=Paths.get("c:\\upload",getFolderYesterDay()).toFile();
		System.out.println("어제날짜 폴더경로명:"+targetDir);
		
		File[] removeFiles=targetDir.listFiles(file->fileListPaths.contains(file.toPath())==false);
		
		System.out.println("-------------------");
		
		for(File file:removeFiles) {
			System.out.println(file.getAbsolutePath());
			
			file.delete();
		}				
	}
}
