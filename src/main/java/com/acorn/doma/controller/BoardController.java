package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


import com.acorn.doma.cmn.PLog;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.service.MarkdownService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.acorn.doma.cmn.Message;
import com.acorn.doma.domain.Board;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Code;
import com.acorn.doma.domain.FileVO;


@Controller
@RequestMapping("board")
public class BoardController implements PLog {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CodeService codeService;
	
	@Autowired
	MarkdownService markdownService;
	
	public BoardController() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ BoardController()         │");
		log.debug("└───────────────────────────┘");
		
	}
	
	// 실제 파일이 저장될 경로 (서버의 절대 경로)
    private static final String UPLOAD_DIR = "C:/Users/acorn/Documents/DOMA/src/main/webapp/resources/img/board_img/";

    @PostMapping(value = "/fileSave.do", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String fileSave(Board inVO, @RequestParam(value = "imgFile", required = false) MultipartFile file) throws SQLException {
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ fileSave()                               │");
        log.debug("└──────────────────────────────────────────┘");

        // 파일 처리
        if (file != null) {
            try {
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

        String jsonString;
        String message;

        // 데이터베이스에 저장
        int flag = boardService.fileSave(inVO);
        if (flag == 1) {
            message = inVO.getTitle() + "이 저장되었습니다.";
        } else {
            message = "게시물 저장에 실패했습니다.";
        }

        jsonString = new Gson().toJson(new Message(flag, message));
        log.debug("2. jsonString : " + jsonString);

        return jsonString;
    }
	
	
	/**
	 * 공지사항 상세페이지 이동
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/anMoveToReg.do
	 */
	@RequestMapping(value = "/anMoveToReg.do"
			   , method = RequestMethod.GET)
	public String anMoveToReg(Board inVO, Model model) throws SQLException {
		String viewName = "board/board_anreg";
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), ""));
		
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieveAn(search);
		
		log.debug("1.param inVO:" + inVO);
		model.addAttribute("board", inVO);
		
		return viewName;
	}
	
	/**
	 * 상세페이지 이동
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/moveToReg.do
	 */
	@RequestMapping(value = "/moveToReg.do"
			   , method = RequestMethod.GET)
	public String moveToReg(Board inVO, Model model) throws SQLException {
		String viewName = "board/board_reg";
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), ""));
		
		log.debug("1.param inVO:" + inVO);
		model.addAttribute("board", inVO);
		
		
		
		//reg 구선택--------------------------------------------------------
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	//http://localhost:8080/doma/board/board.do
	//http://localhost:8080/doma/board/doRetrieve.do?div=10
	@GetMapping("/board.do")
	public String boardList(Model model) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ boardList()               │");
		log.debug("└───────────────────────────┘");
		String viewName = "/board/board_list";
		
		return viewName;
	}
	
	/**
	 * 다건 조회
	 * @param model
	 * @param req
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doRetrieveAn.do
	 */
	@RequestMapping(value = "/doRetrieveAn.do"
			   , method = RequestMethod.GET)
	public String doRetrieveAn(Model model, HttpServletRequest req) throws SQLException{
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ doRetrieve()                                 │");
		log.debug("└──────────────────────────────────────────────┘");
		
		String viewName = "board/board_anlist";
		
		Search search = new Search();
		
		String div = StringUtil.nvl(req.getParameter("div"), "20");
		search.setDiv(div);
		
		String searchGu = StringUtil.nvl(req.getParameter("searchGu"), "");
		search.setSearchGu(searchGu);
		
		//검색구분
		//검색 null 처리 : null -> ""
		String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"), "");
		String searchWord = StringUtil.nvl(req.getParameter("searchWord"), "");
		
		search.setSearchDiv(searchDiv);
		search.setSearchWord(searchWord);
		
		//브라우저에서 숫자 : 문자로 들어 온다.
		String pagsSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
		String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");
		
		search.setPageSize(Integer.parseInt(pagsSize));
		search.setPageNo(Integer.parseInt(pageNo));
		
		log.debug("1. search:" + search);
		
		List<Board> list = this.boardService.doRetrieveAn(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		
		//MEMBER_SEARCH : 회원 검색 조건
		code.setMstCode("BOARD_SEARCH");
		List<Code> memberSearch = this.codeService.doRetrieveAn(code);
		model.addAttribute("BOARD_SEARCH", memberSearch); //검색조건
		
		//COM_PAGE_SIZE : 페이지 사이즈
		code.setMstCode("COM_PAGE_SIZE");
		List<Code> pageSizeSearch = this.codeService.doRetrieveAn(code);
		model.addAttribute("COM_PAGE_SIZE", pageSizeSearch); //페이지 사이즈
		
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieveAn(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 다건 조회
	 * @param model
	 * @param req
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doRetrieve.do
	 */
	@RequestMapping(value = "/doRetrieve.do"
			   , method = RequestMethod.GET)
	public String doRetrieve(Model model, HttpServletRequest req) throws SQLException{
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ doRetrieve()                                 │");
		log.debug("└──────────────────────────────────────────────┘");
		
		String viewName = "board/board_list";
		
		Search search = new Search();
		
		String div = StringUtil.nvl(req.getParameter("div"), "10");
		search.setDiv(div);
		
		String searchGu = StringUtil.nvl(req.getParameter("searchGu"), "");
		search.setSearchGu(searchGu);
		
		//검색구분
		//검색 null 처리 : null -> ""
		String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"), "");
		String searchWord = StringUtil.nvl(req.getParameter("searchWord"), "");
		
		search.setSearchDiv(searchDiv);
		search.setSearchWord(searchWord);
		
		//브라우저에서 숫자 : 문자로 들어 온다.
		String pagsSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
		String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");
		
		search.setPageSize(Integer.parseInt(pagsSize));
		search.setPageNo(Integer.parseInt(pageNo));
		
		log.debug("1. search:" + search);
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		
		//MEMBER_SEARCH : 회원 검색 조건
		code.setMstCode("BOARD_SEARCH");
		List<Code> memberSearch = this.codeService.doRetrieve(code);
		model.addAttribute("BOARD_SEARCH", memberSearch); //검색조건
		
		//COM_PAGE_SIZE : 페이지 사이즈
		code.setMstCode("COM_PAGE_SIZE");
		List<Code> pageSizeSearch = this.codeService.doRetrieve(code);
		model.addAttribute("COM_PAGE_SIZE", pageSizeSearch); //페이지 사이즈
		
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 공지사항 업데이트
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/anUpdate.do
	 */
	@RequestMapping(value = "/anUpdate.do"
			   , method = RequestMethod.POST            //textarea post로
			   , produces = "text/plain;charset=UTF-8") //json encoding 
	@ResponseBody //json으로 리턴하기 위한
	public String anUpdate(Board inVO) throws SQLException {
		
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		int flag = boardService.anUpdate(inVO);
		log.debug("2.flag:" + flag);
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 수정 되었습니다.";
		}else {
			message = inVO.getUserId() + "수정 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 업데이트
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doUpdate.do
	 */
	@RequestMapping(value = "/doUpdate.do"
			   , method = RequestMethod.POST            //textarea post로
			   , produces = "text/plain;charset=UTF-8") //json encoding 
	@ResponseBody //json으로 리턴하기 위한
	public String doUpdate(Board inVO) throws SQLException {
		
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		int flag = boardService.doUpdate(inVO);
		log.debug("2.flag:" + flag);
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 수정 되었습니다.";
		}else {
			message = inVO.getUserId() + "수정 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 단건 삭제
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doDelete.do
	 */
	@RequestMapping(value = "/doDelete.do"
	    	, method = RequestMethod.GET
	        , produces = "text/plain;charset=UTF-8"
	        ) //produces : 화면으로 전송 encoding)
	@ResponseBody
	public String doDelete(Board inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		int flag = boardService.doDelete(inVO);
		
		log.debug("1.flag:" + flag);
		String message = "";
		
		if(1 == flag) {
			message = inVO.getSeq() + "이 삭제 되었습니다.";
		}else {
			message = inVO.getSeq() + "삭제 실패 되었습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 단건 조회
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doSelectOne.do
	 */
	@RequestMapping(value = "/anSelectOne.do"
			, method = RequestMethod.GET
			, produces = "text/plain;charset=UTF-8") 
	public String anSelectOne(Board inVO, Model model) throws SQLException {
		String viewName = "board/board_anmain";
		String jsonString = "";
		log.debug("1.param inVO :" + inVO);
		
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		Board outVO = boardService.anSelectOne(inVO);
		
		//markdown으로 contents변경
		String markdownContents = this.markdownService.convertMarkdownToHtml(outVO.getContent());
		
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
		
		model.addAttribute("markdownContents", markdownContents);
		model.addAttribute("board", outVO);
		model.addAttribute("message", message);
		
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 단건 조회
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doSelectOne.do
	 */
	@RequestMapping(value = "/doSelectOne.do"
			, method = RequestMethod.GET
			, produces = "text/plain;charset=UTF-8") 
	public String doSelectOne(Board inVO, Model model) throws SQLException {
		String viewName = "board/board_main";
		String jsonString = "";
		log.debug("1.param inVO :" + inVO);
		
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		Board outVO = boardService.doSelectOne(inVO);
		
		//markdown으로 contents변경
		String markdownContents = this.markdownService.convertMarkdownToHtml(outVO.getContent());
		
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
		
		model.addAttribute("markdownContents", markdownContents);
		model.addAttribute("board", outVO);
		model.addAttribute("message", message);
		
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 공지사항 단건 등록
	 * @param user
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/anSave.do
	 */
	@RequestMapping(value = "/anSave.do"
				   , method = RequestMethod.POST
				   , produces = "text/plain;charset=UTF-8"
				   ) //produces : 화면으로 전송 encoding
	@ResponseBody
	public String anSave(Board inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param inVO:" + inVO);
		
		int flag = boardService.anSave(inVO);
		log.debug("2.flag:" + flag);
		
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 등록 되었습니다.";
		}else {
			message = inVO.getUserId() + "님 등록 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		//json 출력을 가지런하게!
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}
	
	/**
	 * 단건 등록
	 * @param user
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doSave.do
	 */
	@RequestMapping(value = "/doSave.do"
				   , method = RequestMethod.POST
				   , produces = "text/plain;charset=UTF-8"
				   ) //produces : 화면으로 전송 encoding
	@ResponseBody
	public String doSave(Board inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param inVO:" + inVO);
		
		int flag = boardService.doSave(inVO);
		log.debug("2.flag:" + flag);
		
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 등록 되었습니다.";
		}else {
			message = inVO.getUserId() + "님 등록 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		//json 출력을 가지런하게!
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/boardInfo.do"
			, method = RequestMethod.GET
			, produces = "text/plain;charset=UTF-8")  
	public String MyPage(HttpSession session,Model model,Board inVO)throws Exception {
		String viewName = "/board/board_main";
		String jsonString = "";
		log.debug("1.param inVO :" + inVO);
		
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		Board outVO = boardService.doSelectOne(inVO);
		
		//markdown으로 contents변경
		String markdownContents = this.markdownService.convertMarkdownToHtml(outVO.getContent());
		
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
		
		model.addAttribute("markdownContents", markdownContents);
		model.addAttribute("board", outVO);
		model.addAttribute("message", message);
		
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 공지사항 수정페이지 이동
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/moveToReg.do
	 */
	@RequestMapping(value = "/anMoveToUp.do"
			   , method = RequestMethod.GET)
	public String anMoveToUp(HttpSession session,Model model,Board inVO) throws SQLException {
		String viewName = "board/board_anmng";
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), ""));
		
		Board moveUp = boardService.moveUpdate(inVO);
		model.addAttribute("moveUp", moveUp);
		
		Board outVO = boardService.anSelectOne(inVO);
		log.debug("1.param outVO:" + outVO);
		model.addAttribute("board", outVO);
		
		//reg 구선택--------------------------------------------------------
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieveAn(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieveAn(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 수정페이지 이동
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/moveToReg.do
	 */
	@RequestMapping(value = "/moveToUp.do"
			   , method = RequestMethod.GET)
	public String moveToUp(HttpSession session,Model model,Board inVO) throws SQLException {
		String viewName = "board/board_mng";
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), ""));
		
		Board moveUp = boardService.moveUpdate(inVO);
		model.addAttribute("moveUp", moveUp);
		
		Board outVO = boardService.doSelectOne(inVO);
		log.debug("1.param outVO:" + outVO);
		model.addAttribute("board", outVO);
		
		//reg 구선택--------------------------------------------------------
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	
}
