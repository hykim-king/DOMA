package com.acorn.doma.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Code;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.BoardMapper;
import com.acorn.doma.mapper.CommentsMapper;
import com.acorn.doma.mapper.DeathMapper;
import com.acorn.doma.mapper.UserMapper;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CommentsService;
import com.acorn.doma.service.DeathService;
import com.acorn.doma.service.MarkdownService;
import com.acorn.doma.service.UserService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.acorn.doma.cmn.Message; 

@Controller
@RequestMapping("mypage")
public class MyPageController implements PLog {
	
	//─────────────────────────────────서비스
	@Autowired 
	UserService userService;
	
	@Autowired 
	BoardService boardService;
	
	@Autowired 
	CommentsService commentService;
	
	@Autowired
	DeathService deathService;
	
	//─────────────────────────────────매퍼
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	CommentsMapper commentMapper;
	
	 
	 
	@Autowired
	DeathMapper deathMapper;
	
	
	 private static final String UPLOAD_DIR = "C:/Users/acorn/git/DOMA/src/main/webapp/resources/img/board_img/";
		//C:/Users/acorn/git/DOMA/src/main/webapp/resources/img/board_img/
	    //C:/Users/acorn/Documents/DOMA/src/main/webapp/resources/img/board_img/

	 
	public MyPageController() { 
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ MyPageController()                       │");
		log.debug("└──────────────────────────────────────────┘");	
	}

	@GetMapping("myPage.do")
	public String MyPage(HttpSession session,Model model)throws Exception {
		String viewName = "/mypage/MyPage";
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ mypage()                                 │");
		log.debug("└──────────────────────────────────────────┘");
		///WEB-INF/views/+viewName+.jsp
		return viewName;
	}
	
	
	
	
	
	@RequestMapping(value = "/mpSelect.do", method = RequestMethod.GET)
	public String moveToBoard(HttpSession session, Model model,Board inVO) throws SQLException {
	    String viewName = "mypage/MyPageBoard";
	    
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        log.debug("User from session: " + user);
	        model.addAttribute("board", user); // Use user instead of inVO
	        
	        List<Board> list = boardMapper.mpSelect(inVO); 
	        log.debug(list);
		    model.addAttribute("list", list); 
		    
	    } else {
	        log.debug("No user in session"); 
	    }
	    
	    return viewName;
	}
	
	
	
	@RequestMapping(value = "/mpCommentSelect.do", method = RequestMethod.GET)
	public String moveToComment(HttpSession session, Model model,Comments inVO) throws SQLException {
	    String viewName = "mypage/MyPageComment";
	    
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        log.debug("User from session: " + user);
	        model.addAttribute("comment", user); // Use user instead of inVO
	        
	        List<Comments> list = commentMapper.mpCommentSelect(inVO); 
	        log.debug(list);
		    model.addAttribute("list", list); 
		    
	    } else {
	        log.debug("No user in session"); 
	    }
	    
	    return viewName;
	}
	
	
	
	
	@RequestMapping(value = "/doUpdate.do", 
            method = RequestMethod.POST, 
            produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doUpdate(User inVO, HttpSession httpSession) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doUpdate()                │");
		log.debug("└───────────────────────────┘");

    String jsonString = ""; 
		    User sessionUser = (User) httpSession.getAttribute("user");
		    if (sessionUser == null) {
		        log.error("세션에 사용자 정보가 없습니다.");
		        return new Gson().toJson(new Message(0, "세션이 만료되었습니다. 다시 로그인해주세요."));
		    }
		
		    // 2. 기존 등급 설정
		    inVO.setGrade(sessionUser.getGrade());
		    inVO.setUserId(sessionUser.getUserId()); // userId도 세션에서 가져오는 것이 안전합니다.
		
		    log.debug("1. 입력 받은 사용자 정보: " + inVO);
		
		    // 3. 사용자 정보 업데이트
		    int flag = userMapper.doUpdate(inVO);
		    log.debug("2. 업데이트 결과 flag: " + flag);
		
		    String message = "";
		    if (flag == 1) {
		        // 4. 데이터베이스에서 최신 사용자 정보 다시 가져오기
		        User updatedUser = userMapper.mpSelectOne(inVO);
		        if (updatedUser != null) {
		            // 5. 세션에 최신 사용자 정보 저장
		            httpSession.setAttribute("user", updatedUser);
		            message = inVO.getUserId() + "님 정보가 성공적으로 수정되었습니다.";
		        } else {
		            message = "사용자 정보를 가져오는 데 실패했습니다.";
		            flag = 0;
		        }
		    } else {
		        message = inVO.getUserId() + "님의 정보 수정에 실패했습니다.";
		    }
		
		    Message messageObj = new Message(flag, message);
		    jsonString = new Gson().toJson(messageObj);
		
		    log.debug("3. 반환할 JSON 문자열: " + jsonString);
		
		    return jsonString;
		}

	
	@RequestMapping(value = "/mpGradeUp.do", 
			method = RequestMethod.POST, 
			produces = "text/plain;charset=UTF-8") // produces	 																									// encoding
	@ResponseBody
	public String mpGradeUp(User inVO, HttpSession httpSession) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ mpGradeUp()                │");
		log.debug("└───────────────────────────┘");

		String jsonString = "";

		// 1.
		log.debug("1.param:" + inVO);

		int flag = userMapper.mpGradeUp(inVO);

		// 2.
		log.debug("2.flag:" + flag);
		String message = "";
		if (1 == flag) {
			message = inVO.getUserId() + "님이 탈퇴 되었습니다.";
			httpSession.setAttribute("user", inVO);
			
			flag = 1;
		} else {
			message = inVO.getUserId() + "탈퇴 실패 했습니다.";
		}

		Message messageObj = new Message(flag, message);

		Gson gson = new Gson();
		jsonString = gson.toJson(messageObj);

		// 3.
		log.debug("3.jsonString:" + jsonString);

		return jsonString;
	} 
	
	 @RequestMapping(value = "/mpSelect.do", 
			 method = RequestMethod.POST, 
			 produces = "application/json;charset=UTF-8")
	  
	 @ResponseBody 
	 public List<Board> mpSelect(Board inVO,Model model) throws SQLException { 
		 log.debug("1.param:" + inVO); 
	    List<Board> list = boardMapper.mpSelect(inVO); log.debug(list);
	    model.addAttribute("list", list); 
	    return list; 
	    
	 }
	 
	 /**
		 * 단건 조회
		 * @param inVO
		 * @param model
		 * @return
	 * @throws Exception 
		 */
	 @RequestMapping(value = "/mpBoardSelectOne.do", 
			 method = RequestMethod.GET, 
			 produces = "text/plain;charset=UTF-8") 
	 public String mpBoardSelectOne(Board inVO, Model model) throws SQLException  {
		 log.debug("┌─────────────────────┐");
		 log.debug("│     boardSelect     │");
		 log.debug("└─────────────────────┘");
		 String viewName = "mypage/MyPageBoard_u";
		 log.debug("1.param inVO :" + inVO); 
		 inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
			
		 Board outVO = boardService.doSelectOne(inVO);
		 	
			log.debug("2.outVO :" + outVO);
			
			String message = "";
			int flag = 0;
			if(null != outVO) {
				message = outVO.getTitle() + "이 조회 되었습니다.";
				flag = 1;
			}else {
				message = outVO.getTitle() + "조회 실패 했습니다.";
			}
			
			Message messageObj = new Message(flag, message);
			 
			model.addAttribute("board", outVO);
			model.addAttribute("message", message);
			
	     return viewName;
	 }
	 
	 
	@RequestMapping(value = "/mpBoardUp.do"        //textarea post로
			   , produces = "text/plain;charset=UTF-8") //json encoding 
	@ResponseBody //json으로 리턴하기 위한 
		 public String mpBoardUp(Board inVO, @RequestParam(value = "imgFile", required = false) MultipartFile file) throws SQLException {
				log.debug("┌──────────────────────────────────────────┐");
				log.debug("│ safeController : doUpdate()              │");
				log.debug("└──────────────────────────────────────────┘");
				
				// 1. 기존 이미지 파일 경로 가져오기
			    Board existingBoard = boardService.doSelectOne(inVO); // 기존 데이터 가져오기
			    String existingImageFileName = existingBoard.getImgLink(); // 기존 이미지 파일명 가져오기

			    // 2. 새 파일이 업로드 되었는지 확인
			    if (file != null) {
			        try {
			            // 3. 기존 파일 삭제
			            if (existingImageFileName != null && !existingImageFileName.isEmpty()) {
			                String existingFilePath = UPLOAD_DIR + existingImageFileName;
			                File existingFile = new File(existingFilePath);
			                if (existingFile.exists()) {
			                    boolean deleted = existingFile.delete();
			                    if (deleted) {
			                        log.debug("기존 이미지 파일 삭제 성공: " + existingImageFileName);
			                    } else {
			                        log.warn("기존 이미지 파일 삭제 실패: " + existingImageFileName);
			                    }
			                }
			            }
			            
			            // 4. 파일 처리
		            	log.debug("file : " + file);
		            	
		            	
		            	// uuid로 랜덤한 고유번호 부여
		            	UUID uuid = UUID.randomUUID(); 
		            	
		                // 서버의 특정 경로에 파일 저장
		                String originalFileName = file.getOriginalFilename();
		                String imageFileName = uuid + "_" + file.getOriginalFilename();
		                String filePath = UPLOAD_DIR + imageFileName;
		                File uploadFile = new File(filePath);

		                // 파일 저장
		                file.transferTo(uploadFile);

		                // 파일 경로를 웹 애플리케이션의 접근 가능한 경로로 설정
		                String relativeFilePath = "/resources/img/board_img/" + imageFileName;
		                inVO.setImgLink(imageFileName);

		            } catch (IOException e) {
		                log.error("File upload error: ", e);
		                return new Gson().toJson(new Message(0, "파일 업로드에 실패했습니다."));
		            }
		        } else {
		            log.warn("파일이 없습니다.");
		        }

		        log.debug("1. inVO : " + inVO);
		        
				String jsonString = "";
				
				int flag = boardService.fileUpdate(inVO);
				log.debug("2.flag:" + flag);
				
				String message = "";
				if(1 == flag) {
					message = "게시물 수정 되었습니다.";
				}else {
					message = "게시물 수정에 실패했습니다.";
				}
				
				Message messageObj = new Message(flag, message);
				jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
				log.debug("3.jsonString:" + jsonString);
				
				return jsonString;
		
	}
	 
  
	 
		
}
	
	
	
	
	 
