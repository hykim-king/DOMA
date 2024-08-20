package com.acorn.doma.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.FileVO;

@Controller
@RequestMapping("board")
public class FileController implements PLog {
	
	//none image 파일
	final String FILE_PATH = "C:\\upload";
	
	//image 파일
	final String IMG_PATH = "C:/Users/acorn/git/DOMA/src/main/webapp/resources/img/board_img";

	private String yyyyMMPath = "";//년월 포함 경로
	private String saveFilePath = "";//none image 파일 절대경로
	private String saveImageFilePath = "";//image 파일 절대경로
	
	public FileController() {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ FileController()                         │");
		log.debug("└──────────────────────────────────────────┘");
		
		
		//FILE_PATH 생성
		File normalFileRoot =new File(FILE_PATH);
		
		if(normalFileRoot.isDirectory() == false) {//디렉토리가 없으며
			boolean isMakeDir=normalFileRoot.mkdirs();
			log.debug("isMakeDir:"+isMakeDir);
		}
		
		//IMG_PATH 생성
		File imageFileRoot =new File(IMG_PATH);
		if(imageFileRoot.isDirectory() == false) {
			boolean isMakeDir = imageFileRoot.mkdirs();
			log.debug("imageFileRoot:"+isMakeDir);
		}
		
		
		//2024/08
		//    /09
		//    /10
		//2025/01
		
		//C:\\upload\\2024\08
		
		String yyyy = StringUtil.getCurrentDate("yyyy");
		String mm   = StringUtil.getCurrentDate("MM");
		
		log.debug("yyyy:"+yyyy);
		log.debug("mm:"+mm);
		//\2024\08
		this.yyyyMMPath = File.separator+yyyy+ File.separator+mm;
		log.debug("yyyyMMPath:"+yyyyMMPath);
		
		normalFileRoot = new File(FILE_PATH+yyyyMMPath);
		if(normalFileRoot.isDirectory() == false) {
			boolean isMakeDir = normalFileRoot.mkdirs();
			log.debug("isMakeDir:"+isMakeDir);
		}
		
		imageFileRoot =new File(IMG_PATH+yyyyMMPath);
		if(imageFileRoot.isDirectory() == false) {
			boolean isImageFileRoot=imageFileRoot.mkdirs();
			log.debug("isImageFileRoot:"+isImageFileRoot);
		}
		
		
		saveFilePath = normalFileRoot.getAbsolutePath();
		log.debug("saveFilePath:"+saveFilePath);
		
		saveImageFilePath = imageFileRoot.getAbsolutePath();
		log.debug("saveImageFilePath:"+saveImageFilePath);
	}
	
	
	//파일 업로드 처리
	@RequestMapping(value = "/fileUpload.do",method = RequestMethod.POST)
	public ModelAndView fileUpload(ModelAndView modelAndView, MultipartHttpServletRequest mHttp) {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ fileUpload()                             │");
		log.debug("└──────────────────────────────────────────┘");			
		//title
		String title = StringUtil.nvl(mHttp.getParameter("title"),"");
		log.debug("title:"+title);
		
		//contents
		String content = StringUtil.nvl(mHttp.getParameter("content"),"");
		log.debug("content:"+content);
		
		//파일들 읽기
		List<FileVO>  list=new ArrayList<FileVO>();
		
		//<input type="file"  name="file1"
		//<input type="file"  name="file2"
		Iterator<String> fileNames =  mHttp.getFileNames();
		while(fileNames.hasNext()) {
			FileVO fileVO=new FileVO();
			
			String uploadFileName = fileNames.next();
			
			MultipartFile multipartFile = mHttp.getFile(uploadFileName);
			
			//파일이 없는 경우
			if(multipartFile.isEmpty() == true) {
				continue;
			}
			//---------------------------------------------------------------
			//원본 파일명
			String orgFileName = multipartFile.getOriginalFilename();
			log.debug("orgFileName:"+orgFileName);
			
			fileVO.setOrgFileName(orgFileName);

			//파일 확장자
			String ext = StringUtil.getExt(orgFileName);
			log.debug("ext:"+ext);
			
			fileVO.setExtension(ext);
			
			//파일 사이즈
			long fileSize = multipartFile.getSize();//byte
			log.debug("fileSize:"+fileSize);
			
			fileVO.setFileSize(fileSize);
			
			//저장 파일명
			String saveFileName = StringUtil.getDateUUID("yyyyMMddhhmmss")+"."+ext;
			log.debug("saveFileName:"+saveFileName);
			fileVO.setSaveFileName(saveFileName);
			
			//저장 경로: FILE_PATH+/2024/08/
			String contentType =  multipartFile.getContentType();
			log.debug("contentType:"+contentType);
			String saveFilePath = "";
			if(contentType.startsWith("image")==true) {//image파일
				saveFilePath = this.saveImageFilePath;
			}else {
				saveFilePath = this.saveFilePath;
			}
			
			log.debug("saveFilePath:"+saveFilePath);
			fileVO.setSavePath(saveFilePath);
			
			log.debug("********************");
			log.debug("fileVO:"+fileVO);
			log.debug("********************");
			
			try {
				multipartFile.transferTo(new File(fileVO.getSavePath(),fileVO.getSaveFileName()));
			}catch (IOException e) {
				log.debug("IOException:"+e.getMessage());
			}
			
			list.add(fileVO);
			//---------------------------------------------------------------			
		}
		modelAndView.addObject("fileList", list);
		modelAndView.setViewName("board/fileUpload");
		
		return modelAndView;
	}
	
	//파일 업로드 화면
	//http://localhost:8080/doma/board/fileUpload.do
	@GetMapping("/fileUpload.do")
	public ModelAndView fileUploadView(ModelAndView modelAndView) {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ fileUploadView()                         │");
		log.debug("└──────────────────────────────────────────┘");		
		modelAndView.setViewName("board/fileUpload");
		
		return modelAndView;
	}
}