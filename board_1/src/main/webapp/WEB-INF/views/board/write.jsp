<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
   integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
   crossorigin="anonymous">
<style>
body {
  padding-top: 70px;
  padding-bottom: 30px;
}
 
</style>
<title>게시물 작성</title>
</head>
<body>
<article> 
<div class="container" role="main">
         <h2>게시물 작성</h2>
<form method="post" name="form" id="form" role="form"><!-- POST 방식은 폼 데이터를 별도로 첨부하여 서버로 전달하는 방식 -->
<!--주의! 입력 엘리먼트인 <input> 과 <textarea>의 이름(name) 속성의 값이 BoardVO와 동일해야함  -->
  <input name="articleNO" type="hidden" value="${board.articleNO }">
<div class="mb-3">
<label style="width:70px;">제목</label>
<input type="text" name="title" placeholder="제목을 입력해 주세요" name="title"/><br />
</div>
<div class="mb-3">
<label style="width:70px;">작성자</label>
<input type="text" name="writer"  placeholder="이름을 입력해 주세요" name="writer" /><br />
</div>
<div class="mb-3">
<label style="width:70px;">글 선택</label>
<input type="radio" name="notice" value="1"  name="notice"/>공지사항 
<input type="radio" name="notice" value="0" name="notice"/>일반글<br />
</div>
<div class="mb-3">
<label style="width:70px;">내용</label>
<textarea cols="50" rows="5" name="content" placeholder="내용을 입력해 주세요" name="content"></textarea><br />
</div>
<button type="submit" class="btn btn-sm btn-primary" id="btnSave">작성</button>

</form>
</div>
</article>
</body>
</html>