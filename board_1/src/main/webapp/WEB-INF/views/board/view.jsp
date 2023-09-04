<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<style>
body {
   padding-top: 70px;
   padding-bottom: 30px;
}
a {
	text-decoration: none;
	color: white;
}

a:hover {
	text-decoration: none;
	color: white;
}
</style>

<title>게시물 조회</title>
</head>
<body>
	<!-- nav.jsp 글작성, 글 목록 버튼 -->
<%-- 	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div> --%>
 <article>
      <div class="container" role="main">
         <h2>게시물  상세보기</h2>
<!--주의! 입력 엘리먼트인 <input> 과 <textarea>의 이름(name) 속성의 값이 BoardVO와 동일해야함  -->
<div class="mb-3">
<label style="width:70px;" >제목</label>
${view.title}<br />
 </div>

<div class="mb-3">
<label style="width:70px;">작성자</label>
 ${view.writer} <br />
  </div>
 
 <div class="mb-3">
 <label style="width:70px;">글 종류 :</label>
<c:choose>
	<c:when test="${view.notice eq 1}">
		공지사항
	</c:when>
	<c:otherwise>
		일반글
	</c:otherwise>
</c:choose> <br />
 </div>

<div class="mb-3">
<label style="width:70px;">조회수 :</label>
${view.viewCnt} <br />
 </div>

<div class="mb-3">
<label style="width:70px;">내용</label>
${view.content}<br />
 </div>
 
<%--  <div>
 <button type="submit" class="btn btn-sm btn-primary" id="btnSave">
 <a href="/modify?bno=${view.bno}">게시물 수정</a>
 </button>
 </div> --%>
 
 <button type="submit" class="btn btn-sm btn-primary" > <a href="/modify?bno=${view.bno}">수정</a></button>
 <button type="submit" class="btn btn-sm btn-primary" > <a href="/delete?bno=${view.bno}">삭제</a></button>
 
 <button type="submit" class="btn btn-sm btn-primary" > <a href="/reply?bno=${view.bno}&amp;parentNO=${view.bno}">답글</a></button>
 
 <button type="button" class="btn btn-sm btn-primary" > <a href="/main">목록</a></button>
 </div>
 </article>
 
 
</body>
</html>