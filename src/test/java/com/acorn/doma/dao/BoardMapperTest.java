	package com.acorn.doma.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Board;
import com.acorn.doma.mapper.BoardMapper;
import com.acorn.doma.cmn.Search;

@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class BoardMapperTest implements PLog{
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	BoardMapper boardMapper;
	
	Board board01;
	Board board02;
	Board board03;
	
	//안전정보페이지 테스트
	Board safe01;
	Board safe02;
	
	Search search;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		board01 = new Board(1,"10","마포구","제목_01","admin","admin","내용_01","1111","사용안함","사용안함",0);
		board02 = new Board(2,"10","마포구","제목_02","admin","admin","내용_02","1111","사용안함","사용안함",0);
		board03 = new Board(3,"10","마포구","제목_03","admin","admin","내용_03","1111","사용안함","사용안함",0);
		
		safe01 = new Board(411,"30","안전정보페이지_01","user1","user1","내용_03","1111","sysdate","sysdate",0);
		safe02 = new Board(5,"40","위급상황 대처방법_01","user1","user1","내용_03","1111","사용안함","사용안함",0);
		//boardMapper.deleteAll();
		
		search = new Search();
		
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	public void isSameBoard(Board boardIn, Board boardOut) {
		assertEquals(boardIn.getSeq(), boardOut.getSeq());
		assertEquals(boardIn.getDiv(), boardOut.getDiv());
		assertEquals(boardIn.getGname(), boardOut.getGname());
		assertEquals(boardIn.getTitle(), boardOut.getTitle());
		assertEquals(boardIn.getUserId(), boardOut.getUserId());
		assertEquals(boardIn.getModId(), boardOut.getModId());
		assertEquals(boardIn.getContent(), boardOut.getContent());
		assertEquals(boardIn.getImgLink(), boardOut.getImgLink());
		assertEquals(boardIn.getViews(), boardOut.getViews());
	}
	
	
	@Ignore
	@Test
	public void addAndGet() throws Exception{
		
		//전체 삭제 먼저 setUp()에서
		
		//board01-----------------------
		int flag = boardMapper.doSave(board01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		int seq = boardMapper.getSequence();
		log.debug("seq : " + seq);
		board01.setSeq(seq);
		
		// 단건 조회
		Board outVO01 = boardMapper.doSelectOne(board01);
		log.debug("outVO01 : " + outVO01);
		assertNotNull(outVO01);
		
		
		//board02-----------------------
		flag = boardMapper.doSave(board02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		seq = boardMapper.getSequence();
		log.debug("seq : " + seq);
		board02.setSeq(seq);
		
		// 단건 조회
		Board outVO02 = boardMapper.doSelectOne(board01);
		log.debug("outVO02 : " + outVO02);
		assertNotNull(outVO02);

		
		
		//board03-----------------------
		flag = boardMapper.doSave(board03);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		seq = boardMapper.getSequence();
		log.debug("seq : " + seq);
		board03.setSeq(seq);
		
		// 단건 조회
		Board outVO03 = boardMapper.doSelectOne(board01);
		log.debug("outVO03 : " + outVO03);
		assertNotNull(outVO03);
		

		
		// 단건 삭제
		flag = boardMapper.doDelete(outVO01);
		assertEquals(1, flag);
	}
	
	@Ignore
	@Test
	public void moveUpdate() throws Exception {
		int flag = boardMapper.doSave(board01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		int seq = boardMapper.getSequence();
		log.debug("seq : " + seq);
		board01.setSeq(seq);
		
		Board outVO01 = boardMapper.moveUpdate(board01);
		log.debug("outVO01 : " + outVO01);
		assertNotNull(outVO01);
	}	
	
	@Ignore
	@Test
	public void doUpdate() throws Exception {
		
		int flag = boardMapper.doSave(board01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		int seq = boardMapper.getSequence();
		log.debug("seq : " + seq);
		board01.setSeq(seq);
		
		Board outVO01 = boardMapper.doSelectOne(board01);
		log.debug("outVO01 : " + outVO01);
		assertNotNull(outVO01);
		
		isSameBoard(board01, outVO01);
		
		String updateStr = "_U";
		outVO01.setDiv("10");
		outVO01.setTitle(outVO01.getTitle() + updateStr);
		outVO01.setContent(outVO01.getContent() + updateStr);
		outVO01.setViews(1);
		
		flag = boardMapper.doUpdate(outVO01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		Board outVO01Update = boardMapper.doSelectOne(outVO01);
		log.debug("outVO01Update : " + outVO01Update);
		assertNotNull(outVO01Update);
		
	}
	
	@Ignore
	@Test
	public void doRetrieve() throws SQLException {
		
		boardMapper.deleteAll();
		int flag = boardMapper.multipleSave();
		assertEquals(202, flag);
		search.setDiv("10");
		search.setPageNo(1);
		search.setPageSize(10);
		
		search.setSearchDiv("30");
		//제목000001
		//내용000001
		search.setSearchWord("내용000001");
		
		List<Board> list = boardMapper.doRetrieve(search);
		log.debug("list:"+list);
		assertEquals(5, list.size());

	}
	
	//안전정보페이지용 테스트
	@Ignore
	@Test
	public void save() throws Exception{
		int flag = boardMapper.save(safe01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		flag = boardMapper.save(safe02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
	}
	
	@Ignore
	@Test
	public void Retrieve() throws Exception {
		//div : 30
		search.setDiv("30");
		
		search.setPageNo(1);
		search.setPageSize(10);
		
		List<Board> retrieveList = boardMapper.retrieve(search);
		
		log.debug("retrieveList:" + retrieveList);
		assertEquals(4, retrieveList.size());
		
		//div : 40
		search.setDiv("40");
		
		search.setPageNo(1);
		search.setPageSize(10);
		
		List<Board> retrieveList02 = boardMapper.retrieve(search);
		
		log.debug("retrieveList02:" + retrieveList02);
		assertEquals(5, retrieveList.size());
		
	}
	
	
	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("boardMapper:" + boardMapper);

		assertNotNull(context);
		assertNotNull(boardMapper);
	}

}