<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		request.setCharacterEncoding("utf-8");
		String msg = (String)request.getAttribute("msg");
		String contextPath = request.getContextPath();
		//control
		String realPath = contextPath + "/CtrlMember.do";
		//css
		String cssPath = contextPath + "/shopFrame/css/shop_login.css";
		//javaScript
		String javaScriptPath = contextPath + "/shopFrame/js/shop_login.js";
		//img
		String imgPath1 = contextPath + "/shopFrame/img/icon/search.png";
		String imgPath2 = contextPath + "/shopFrame/img/logo.png";
	%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>로그인 페이지</title>
	<link rel="stylesheet" href="<%=cssPath%>">
	<script src="<%=javaScriptPath%>"></script>
</head>
<body onLoad="mInit()">
	<div id="wrapper">
		<form method = "post" action = "<%=realPath %>">
		
		<input type="hidden" value="" name="user_id" id="user_id">
		<input type="hidden" value="" name="user_pwd" id="user_pwd">
		<input type="hidden" value="proLog" name="page" id="page">
		
		<input type="hidden" value="<%= (msg != null) ? msg : "로그인 페이지입니다" %>" id="msg">
			<div class="header">
				<!--<div class="logo"><img src = "./../img/logo.png"></div>-->
				<div class="nav1">
					<p>고객센터</p>
					<p>마이페이지</p>
					<p>관심</p>
					<p>알림</p>
					<p>로그인</p>
				</div>
				<div class="nav2">
					<p onclick = "controlSend('pageMain')">HOME</p>
					<p>STYLE</p>
					<p>SHOP</p>
					<img src="<%=imgPath1%>">
				</div>
			</div>
			<div class="main">
				<div class="logo" onclick = "controlSend('pageMain')"><img src = "<%=imgPath2%>"></div>
				<div class="login">
				<!--  아이디  -->
					<p>아이디</p>
					<input type="text" id="Log_Id" placeholder="예 ) dream1234  ,  dream@test.com">
				<!--  비밀번호  -->
					<p>비밀번호</p>
					<input type = "password" id = "Log_Pwd">
				<!--  로그인 버튼 -->
					<input type = "button" value = "로그인" onclick = "loginSend()">
					<div class="link">
						<span onclick = "controlSend('pageMember')">아이디 가입</span>
						<span onclick = "controlSend('pageIdfind')">아이디 찾기</span>
						<span onclick = "controlSend('pagePwdfind')">비밀번호 찾기</span>
					</div>
					<div class="api">
						<input type="button" value="네이버로 로그인">
						<input type="button" value="카카오로 로그인">
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>