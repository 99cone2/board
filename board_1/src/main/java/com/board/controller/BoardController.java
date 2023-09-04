package com.board.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.PageMaker;
import com.board.service.BoardService;

@Controller
public class BoardController {
	
	private static final Logger logger =  LoggerFactory.getLogger(BoardController.class);
	 
	@Inject
	BoardService service;
	
	@Autowired
	private HttpSession httpSession;

	//게시물 목록 +페이징
		@RequestMapping(value = "/main", method = RequestMethod.GET)
			public String getList(Model model,Criteria cri) throws Exception  {
				logger.info("리스트 페이지 가져오기");
				
				//게시물 목록
				 List<BoardVO> list= null;
				 list= service.list(cri);
				 model.addAttribute("list",list);
				 //Model은 컨트롤러와 뷰를 연결해주는 역할-> 컨트롤러에서 처리한 결과를 뷰 즉 jsp에 전달하는 역할 "list"는 명칭 list는 변수
				 //<!-- controller에 있는 변수 list를 가져오는거 표시->(ㅣlist.jsp의)items="${list}" 이걸 list로 쓰겠다고 선언하는것 var="list" 
				 // <td>${list.bno}</td>의 list는 var="list"임 -→//
			
				 //게시판 페이징   가져오기.
				 PageMaker pageMaker= new PageMaker();
				 pageMaker.setCri(cri);
				 pageMaker.setTotalCount(service.listCount());
				 model.addAttribute("pageMaker",pageMaker);
				 
				 
				 
				 
				 
				 return "list";
			}
	
		

	// 게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWirte() throws Exception {
	   
	}
	
	// 게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String posttWirte(BoardVO vo) throws Exception {
	  service.write(vo);
	  
	  //모든 작업을 마치고 목록 화면으로 이동하겠다는 뜻
	  return "redirect:/main";
	}


	//게시물 조회 + 조회수 중복방지
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String getView(@RequestParam("bno")int bno, Model model, BoardVO vo ) throws Exception {
	 	
		//구분 객체 생성, 세션 값 가져오기 (getAttribute : 세션에서 대이터 가져올때 사용), 저장
		//set : 객체 중복 x
		Set<Integer> bnoViewCnt=(Set<Integer>) httpSession.getAttribute("bnoViewCnt");

		//초기 bnoViewCnt null일 때 처리 / 값 만들기...
		// hashSet 데이터 중복x , 순서 상관 없음 (하나라 괜츈)
		if (bnoViewCnt == null) {
			bnoViewCnt = new HashSet<>();
			httpSession.setAttribute("bnoViewCnt",bnoViewCnt);
			}
			

		// bnoViewCnt에 들어있지 않은 값일 때 처리하는 로직-최조 클릭 게시물 조회수 +1 증가 후 bnoViewCnt에 해당 bno 저장
				if(!bnoViewCnt.contains(bno))	{
					service.updateViewCnt(bno);	
					 bnoViewCnt.add(bno);
				}
		
		//게시물 조회
		vo= service.view(bno);
		model.addAttribute("view", vo);
	
		 return "view";
	}
	
	
	
	//게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno")int bno, Model model) throws Exception{
		BoardVO vo= service.view(bno);
		model.addAttribute("view", vo);
	
	}
	
	// 게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(BoardVO vo) throws Exception {

		service.modify(vo);
	   //service.modify(vo);에서 뷰에서 컨트롤러로 넘어온 데이터(BoardVO)를 이용해 수정을 끝내고, return 값으로 이동
	 return "redirect:/view?bno=" + vo.getBno();
	}
	
	// 게시물 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception {
	  
	 service.delete(bno);  
	 //경로 확인 하기...^^
	 //게시물을 삭제 하게 되면 게시물 목록 페이지로 이돋할 수 있도록 반환에   list url 입력 
	 return "redirect:/main";
	}
	
	
	
	//답글 작성-페이지 보여주는것.
	@RequestMapping(value = "/reply",method = RequestMethod.GET)
	public String getReply(@RequestParam("parentNO")int parentNO, Model model,BoardVO vo) throws Exception {
		//parentNO 고정값이 0이라서 값을 가져와야함.
		vo.setParentNO(parentNO);
		//Model은 컨트롤러와 뷰를 연결해주는 역할-> 컨트롤러에서 처리한 결과를 뷰 즉 jsp에 전달하는 역할 "reply"는 명칭 reply는 변수
		model.addAttribute("reply", vo);
		//경로 확인 잘하기. jsp
	   return "reply";
	}
	
	
	//답글작성
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	public String posttReply(BoardVO vo) throws Exception {
	  service.reply(vo);
	  //모든 작업을 마치고 목록 화면으로 이동하겠다는 뜻
	  return "redirect:/main";
	}
	
	
 

	 
	
	
	
}
