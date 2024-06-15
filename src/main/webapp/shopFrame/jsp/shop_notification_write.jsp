<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<%
    //경로 설정
    	String contextPath = request.getContextPath();
		String cssConPath = contextPath + "/shopFrame/css/shop_headerContainer.css";
		String cssMainPath = contextPath + "/shopFrame/css/shop_notification.css";
%>
<link rel="stylesheet" href="<%=cssConPath%>">
<link rel="stylesheet" href="<%=cssMainPath%>">

<%
request.setCharacterEncoding("utf-8");
%>
</head>
<body>
	<div id="container">
		<%@ include file="shop_header.jsp"%>
	</div>
	<div id="wrapper">
	<form action="<%=contextPath%>/CtrlNotification.do" method="post">
	<input type = "hidden" name = "page" value = "write">
		<h1>공지사항 입력하기</h1>
		<div class="blackstick"></div>
		<div class="notification_head">			
			<p>
				제목: <input type="text" class="title" name="notification_Subject" placeholder="제목을 입력하세요">
			</p>
		</div>
		<div class="notification_content">
			<textarea class="contentwrite" name="notification_Content" rows="10" cols="40" placeholder="내용을 입력하세요"></textarea>
		</div>
		<div class="buttons">
			<button type="submit" class="buts">작성</button> 
			<a class="buts" href="<%=contextPath%>/CtrlNotification.do?page=pageNotification">목록 돌아가기</a>
		</div>
	</form>
	</div>
</body>
</html>
