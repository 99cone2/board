package com.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.board.dao.BoardDAO;
import com.board.domain.BoardVO;
import com.board.domain.Criteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	//게시물 목록 +페이징
	@Override
	public List<BoardVO> list(Criteria cri) throws Exception{
		return dao.list(cri);
	}

	//게시물 작성
	@Override
	public void write(BoardVO vo) throws Exception {
		dao.write(vo);
	}
	
	// 게시물 조회
	@Override
	public BoardVO view(int bno) throws Exception {
	
		//단순 조회수 기능일때 사용/ session 중복방지 쓰면 겹침..
		//dao.updateViewCnt(bno);
		return dao.view(bno);
	}
	
	// 게시물 수정
	@Override
	public void modify(BoardVO vo) throws Exception {
	  
	 dao.modify(vo);
	}
	
	// 게시물 삭제
	public void delete(int bno) throws Exception {
	 dao.delete(bno);
	}

	 //조회수
	 @Override	    
	 public void updateViewCnt(int bno) throws Exception {	      
	 	dao. updateViewCnt(bno);	   
	 }
	
	//답글 작성
	@Override
	public void  reply(BoardVO vo) throws Exception {
		dao.reply(vo);
	}
	
	// 게시물 총 갯수
	@Override
	public int listCount() throws Exception {
	 return dao.listCount();
	}

	
	 
}
