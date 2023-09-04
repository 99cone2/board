package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

 @Inject
 private SqlSession sql;
 
 private static String namespace = "com.board.mappers.board";

//게시물 목록 +페이징
 @Override
 public List<BoardVO> list(Criteria cri) throws Exception { 
  
  return sql.selectList(namespace + ".list",cri);
 }
 
 // mapper insert id가 namespace뒤의 이름과 동일
 
 //게시글 작성
 //mapper의 id에 있는거임 write....
 @Override
 public void write(BoardVO vo) throws Exception {
	sql.insert(namespace + ".write", vo);
 }
 
 //게시물 조회
 public BoardVO view(int bno) throws Exception {

 return sql.selectOne(namespace + ".view", bno);
 }

 //게시물 수정
 @Override
 public void modify(BoardVO vo) throws Exception {
 sql.update(namespace + ".modify", vo);
 }
 
 //게시물 삭제
 public void delete(int bno) throws Exception {
 sql.delete(namespace + ".delete", bno);
}
 
 //조회수
 @Override	    
 public void updateViewCnt(int bno) throws Exception {	      
 	sql.update(namespace + ".updateViewCnt", bno);	   
 }
 
 //답글 작성
@Override
public void reply(BoardVO vo) throws Exception {
	sql.insert(namespace+".reply",vo);
	
}

//게시글 총 갯수 확인
//int 등 타입 확인 잘 하기
@Override
public int listCount() throws Exception {
	return sql.selectOne(namespace+".listCount");
}


 


 


}
 