package com.acorn.doma.controller;



import java.io.File;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Board;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("safe")
public class SafeController implements PLog {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CodeService codeService;
	

	// 실제 파일이 저장될 경로 (서버의 절대 경로)
	private static final String UPLOAD_DIR = "C:/Users/acorn/git/DOMA/src/main/webapp/resources/img/board_img/";
   
	public void safeController() {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController()                         │");
		log.debug("└──────────────────────────────────────────┘");	
	};
	
	@PostMapping(value = "/doUpdate.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doUpdate(Board inVO, @RequestParam(value = "imgFile", required = false) MultipartFile[] files) throws SQLException {
	    log.debug("┌──────────────────────────────────────────┐");
	    log.debug("│ safeController : doUpdate()              │");
	    log.debug("└──────────────────────────────────────────┘");

	    // 1. 기존 이미지 파일 경로 가져오기
	    Board existingBoard = boardService.selectOne(inVO); // 기존 데이터 가져오기
	    String existingImageFileNames = existingBoard.getImgLink(); // 기존 이미지 파일명 가져오기

	    // 2. 새 파일이 업로드 되었는지 확인
	    List<String> imgLinks = new ArrayList<>();
	    if (files != null && files.length > 0) {
	        // 3. 기존 파일 삭제
	        if (existingImageFileNames != null && !existingImageFileNames.isEmpty()) {
	            String[] existingFilePaths = existingImageFileNames.split(",");
	            for (String fileName : existingFilePaths) {
	                String existingFilePath = UPLOAD_DIR + fileName;
	                File existingFile = new File(existingFilePath);
	                if (existingFile.exists()) {
	                    boolean deleted = existingFile.delete();
	                    if (deleted) {
	                        log.debug("기존 이미지 파일 삭제 성공: " + fileName);
	                    } else {
	                        log.warn("기존 이미지 파일 삭제 실패: " + fileName);
	                    }
	                }
	            }
	        }

	        // 4. 새로운 파일 저장
	        for (MultipartFile file : files) {
	            try {
	                UUID uuid = UUID.randomUUID();

	                // 서버의 특정 경로에 파일 저장
	                String originalFileName = file.getOriginalFilename();
	                String imageFileName = uuid + "_" + originalFileName;
	                String filePath = UPLOAD_DIR + imageFileName;
	                File uploadFile = new File(filePath);

	                // 파일 저장
	                file.transferTo(uploadFile);

	                // 파일명을 리스트에 추가
	                imgLinks.add(imageFileName);

	            } catch (IOException e) {
	                log.error("File upload error: ", e);
	                return new Gson().toJson(new Message(0, "파일 업로드에 실패했습니다."));
	            }
	        }

	        // 이미지 링크들을 Board 객체에 저장
	        inVO.setImgLink(String.join(",", imgLinks)); // 여러 이미지를 콤마로 구분하여 저장
	    }

	    log.debug("1. inVO : " + inVO);

	    // 5. 데이터베이스 업데이트
	    int flag = boardService.update(inVO);
	    log.debug("2.flag:" + flag);

	    // 6. 결과 메시지 생성
	    String message = (flag == 1) ? inVO.getTitle() + "이 수정 되었습니다." : "게시물 수정에 실패했습니다.";

	    // 7. JSON 응답 생성
	    Message messageObj = new Message(flag, message);
	    String jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
	    log.debug("3.jsonString:" + jsonString);

	    return jsonString;
	}

	
	@RequestMapping(value = "/doDelete.do"
	    	, method = RequestMethod.GET
	        , produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDelete(Board inVO) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : doDelete()              │");
		log.debug("└──────────────────────────────────────────┘");
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		Board existingBoard = boardService.selectOne(inVO); // 기존 데이터 가져오기
	    String existingImageFileNames = existingBoard.getImgLink(); // 기존 이미지 파일명 가져오기

		if (existingImageFileNames != null && !existingImageFileNames.isEmpty()) {
	        String[] imageFileNames = existingImageFileNames.split(",");
	        for (String fileName : imageFileNames) {
	            String filePath = UPLOAD_DIR + fileName;
	            File file = new File(filePath);
	            if (file.exists()) {
	                boolean deleted = file.delete();
	                if (deleted) {
	                    log.debug("이미지 파일 삭제 성공: " + fileName);
	                } else {
	                    log.warn("이미지 파일 삭제 실패: " + fileName);
	                }
	            }
	        }
	    }
		
		int flag = boardService.doDelete(inVO);
		
		log.debug("1.flag:" + flag);
		String message = "";
		
		if(1 == flag) {
			message = inVO.getTitle() + "이 삭제 되었습니다.";
		}else {
			message = "게시글 삭제에 실패했습니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));	
		log.debug("2. jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	@PostMapping(value = "/save.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doSave(Board inVO, 
	                     @RequestParam(value = "imgFile", required = false) MultipartFile[] files) throws SQLException {
	    log.debug("┌──────────────────────────────────────────┐");
	    log.debug("│ safeController : doSave()                │");
	    log.debug("└──────────────────────────────────────────┘");

	    List<String> imgLinks = new ArrayList<>();

	    // 여러 파일 처리
	    if (files != null) {
	        for (MultipartFile file : files) {
	                try {
	                    UUID uuid = UUID.randomUUID();
	                    
	                    // 서버의 특정 경로에 파일 저장
	                    String originalFileName = file.getOriginalFilename();
	                    String imageFileName = uuid + "_" + originalFileName;
	                    String filePath = UPLOAD_DIR + imageFileName;
	                    File uploadFile = new File(filePath);

	                    // 파일 저장
	                    file.transferTo(uploadFile);

	                    // 파일 경로를 웹 애플리케이션의 접근 가능한 경로로 설정
	                    String relativeFilePath = "/resources/img/board_img/" + imageFileName;
	                    imgLinks.add(imageFileName);

	                } catch (IOException e) {
	                    log.error("File upload error: ", e);
	                    return new Gson().toJson(new Message(0, "파일 업로드에 실패했습니다."));
	                }
	            }
	    } else {
	        log.warn("파일이 없습니다.");
	    }

	    // 이미지 링크들을 Board 객체에 저장
	    if (!imgLinks.isEmpty()) {
	        inVO.setImgLink(String.join(",", imgLinks)); // 여러 이미지를 콤마로 구분하여 저장(DB에서 구분)
	    }

	    log.debug("1. inVO : " + inVO);

	    String jsonString;
	    String message;

	    // 데이터베이스에 저장
	    int flag = boardService.save(inVO);
	    if (flag == 1) {
	        message = inVO.getTitle() + "이 저장되었습니다.";
	    } else {
	        message = "게시물 저장에 실패했습니다.";
	    }

	    jsonString = new Gson().toJson(new Message(flag, message));
	    log.debug("2. jsonString : " + jsonString);

	    return jsonString;
	}

	@GetMapping("/selectOne.do")
	public String selectOne(Model model, Board inVO) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : selectOne()             │");
		log.debug("└──────────────────────────────────────────┘");
		
		log.debug("1. inVO : " + inVO);
		
		String viewName = "/safe/safe_selectOne_page";
		
		Board outVO = boardService.selectOne(inVO);
		log.debug("2. outVO : " + outVO);
		
		if (outVO != null && outVO.getImgLink() != null) {
	        String[] imgLinks = outVO.getImgLink().split(",");  // 콤마로 구분된 이미지 경로들을 배열로 변환
	        log.debug("3. imgLinks : " + imgLinks);
	        model.addAttribute("imgLinks", imgLinks);  // 각 이미지 링크를 모델에 추가
	    }
		
		model.addAttribute("info", outVO);
		return viewName;
	}
	
	@GetMapping("/updatePage.do")
	public String updatePage(Model model, Board inVO) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : updatePage()            │");
		log.debug("└──────────────────────────────────────────┘");
		log.debug("inVO : " + inVO);
		
		String viewName = "/safe/safe_update_page";
		
		Board outVO = boardService.selectOne(inVO);
		log.debug("outVO : " + outVO);

		model.addAttribute("target", outVO);
		
		return viewName;
	}
	
	@GetMapping("/savePage.do")
	public String savePage() throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : savePage()              │");
		log.debug("└──────────────────────────────────────────┘");
		String viewName = "/safe/safe_save_page";
		
		return viewName;
	}
	
	@GetMapping("/safePage.do")
	public String safePage(Model model,
	                        @RequestParam(defaultValue = "1") int pageNo) throws SQLException {
	    log.debug("┌──────────────────────────────────────────┐");
	    log.debug("│ safeController : safePage()              │");
	    log.debug("└──────────────────────────────────────────┘");
	    String viewName = "/safe/safe_info";

	    // 첫 번째 리스트 처리 (div: 30)
	    Search search30 = new Search();
	    search30.setDiv("30");
	    search30.setPageNo(pageNo);
	    search30.setPageSize(6);

	    List<Board> list30 = this.boardService.retrieve(search30);
	    int totalCnt30 = list30.isEmpty() ? 0 : list30.get(0).getTotalCnt(); // 총 레코드 수
	    int totalPages30 = (int) Math.ceil((double) totalCnt30 / search30.getPageSize());
	    
	    // 이미지 링크 처리: 각 게시물에서 첫 번째 이미지 링크만 추출
	    for (Board board : list30) {
	        if (board.getImgLink() != null && !board.getImgLink().isEmpty()) {
	            String[] imgLinks = board.getImgLink().split(",");  // 이미지 링크를 콤마로 분리
	            board.setImgLink(imgLinks[0]);  // 첫 번째 이미지 링크만 사용
	        }
	    }
	    
	    model.addAttribute("list30", list30);
	    model.addAttribute("totalPages30", totalPages30);
	    model.addAttribute("pageNo30", pageNo); // 페이지 번호 추가

	    // 두 번째 리스트 처리 (div: 40)
	    Search search40 = new Search();
	    search40.setDiv("40");
	    search40.setPageNo(pageNo);
	    search40.setPageSize(6);

	    List<Board> list40 = this.boardService.retrieve(search40);
	    int totalCnt40 = list40.isEmpty() ? 0 : list40.get(0).getTotalCnt(); // 총 레코드 수
	    int totalPages40 = (int) Math.ceil((double) totalCnt40 / search40.getPageSize());

	    for (Board board : list40) {
	        if (board.getImgLink() != null && !board.getImgLink().isEmpty()) {
	            String[] imgLinks = board.getImgLink().split(",");  // 이미지 링크를 콤마로 분리
	            board.setImgLink(imgLinks[0]);  // 첫 번째 이미지 링크만 사용
	        }
	    }
	    
	    model.addAttribute("list40", list40);
	    model.addAttribute("totalPages40", totalPages40);
	    model.addAttribute("pageNo40", pageNo); // 페이지 번호 추가

	    return viewName;
	}

	
}
