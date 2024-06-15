<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
	request.setCharacterEncoding("utf-8");
	String msg = request.getParameter("msg");
	String contextPath = request.getContextPath();
	//control
	String realPath = contextPath + "/CtrlMember.do";
	//css
	String cssPath = contextPath + "/shopFrame/css/shop_idfind.css";
	//javaScript
	String javaScriptPath = contextPath + "/shopFrame/js/shop_idFind.js";
	//img
	String imgPath1 = contextPath + "/shopFrame/img/icon/search.png";
	String imgPath2 = contextPath + "/shopFrame/img/logo.png";
	%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>비밀번호 페이지</title>
	<link rel="stylesheet" href="<%=cssPath%>">
	<script src="<%=javaScriptPath%>"></script>

</head>
<body onLoad="mInit()">
	<div id="wrapper">
		<form method = "post" action ="<%=realPath%>">
		
		<input type="hidden" value="" name="user_phone" id="user_phone">
		<input type="hidden" value="" name="user_cate" id="user_cate">
		<input type="hidden" value="" name="page" id="page">
		
		
		<input type="hidden" value="<%= (msg != null) ? msg : "아이디 찾기 페이지입니다" %>" id="msg">
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
					<p onclick =  "controlSend('pageMain')">HOME</p>
					<p>STYLE</p>
					<p>SHOP</p>
					<img src="<%=imgPath1%>">
				</div>
			</div>
			<div class="main">
				<div class="logo" onclick = "controlSend('pageMain')"><img src = "<%=imgPath2%>"><br>아이디 찾기</div>
				<div class="login">
				<!--  휴대폰번호  -->
					<p>휴대폰번호</p>
					<input type="text" id="Log_phone" placeholder="가입하신 휴대폰 번호 예 ) 01012345678">
				<!--   버튼 -->
					<input type = "button" value = "문자 발송하기" onclick = "idFind('id')">
					
				
				</div>
			</div>
		</form>
	</div>

</body>
</html>