<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- 날짜  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<title>게시판</title>

<style>
body {
	padding-top: 70px;
	padding-bottom: 30px;
}

h2 {
	text-align: center;
}

a {
	text-decoration: none;
	color: white;
}

a:hover {
	text-decoration: none;
	color: white;
}

.lista {
	text-decoration: none;
	color: black;
}

.lista:hover {
	text-decoration: none;
	color: gray;
}

ul li{
	list-style: none;
	float: left;
	margin-left: 20px;
	text-align: center;
}
 
.pagea {
	text-decoration: none;
	color: black;
}

.pagea:hover {
	text-decoration: none;
	color: gray;
}

#writeButton{
float: right;}

#pageHTML{

display: flex;
flex-flow: row nowrap;
justify-content: center;
}
</style>
</head>
<body>
	<h2>게시판</h2>
	<br>
	
	<article>
		<div class="container">
			<div class="table-responsive">
				<table class="table table-striped table-sm">
					<colgroup>
						<col style="width: 5%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${list}" var="list">  
							<tr>
								<td>${list.bno}</td>
								
								<td>
								<!-- 답글 -->
 									<c:choose>
										<c:when test='${list.lvl>1}'>
											<c:forEach begin="1" end="${list.lvl}" step="1">
												<span style="padding-left: 20px"></span>
											</c:forEach>
												<span style="font-size: 12px;"><img src="resources/img/re.png" width="30px"/></span>
										</c:when>
										<c:otherwise>
										<!-- 최신글 -->
											<!-- 현재시간 -->
											<c:set var="now" value="<%=new java.util.Date()%>" />
											<!-- 현재시간을 숫자로/정수 값만 가져오기 -->
											<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today" />
											<!-- 게시글 작성날짜를 숫자로/정수 값만 가져오기 -->
											<fmt:parseNumber value="${list.regDate.time / (1000*60*60*24)}" integerOnly="true" var="regDate" />
											<!-- 3일동안은 new 표시 -->
											<c:if test="${today - regDate<= 3}">
											<img src="resources/img/hit.png" width="30px" alt="new" />
											</c:if>
										</c:otherwise>  
								</c:choose>
									<a class="lista" href="/view?bno=${list.bno}">${list.title}</a>
								</td>
								
								<td>${list.writer}</td>
								<%-- <td><fmt:formatDate value="${list.regDate}" pattern="yyyy/MM/dd"/></td> --%>
								<td><fmt:formatDate value="${list.regDate}"/></td>
								<td>${list.viewCnt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!--글쓰기 버튼  -->
			<div id="writeButton">
				<button type="button" class="btn btn-sm btn-primary" id="btnWriteForm" ><a href="/write" >글쓰기</a></button>
			</div>
			
		
			
			
		</div>

	</article>


	<!-- 페이징용 HTML 코드 -->
	<div id="pageHTML">
		<ul>
			<!-- 이전 페이지  -->
			<c:if test="${pageMaker.prev}">
				<li><a class="pagea"
					href="/main${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
			</c:if>

			<!-- 페이지 번호들 -->
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<c:choose>
					<c:when test="${idx eq pageMaker.cri.getPage()}">
						<li><a class="pagea " href="/main${pageMaker.makeQuery(idx)}"><strong>${idx}</strong></a></li>
					</c:when>
					<c:otherwise>
						<li><a class="pagea" href="/main${pageMaker.makeQuery(idx)}">${idx}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 다음페이지 -->
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li><a class="pagea"
					href="/main${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
			</c:if>
		</ul>
	</div>

</body>
</html>