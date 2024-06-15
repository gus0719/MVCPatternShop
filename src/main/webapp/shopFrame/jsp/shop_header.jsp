<%@ page import = "shop.ShopUserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%
String headerContext = request.getContextPath();
String prj = request.getContextPath()+"/shopFrame";
%>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel = "stylesheet" href = "<%=prj%>/css/shop_header.css">
<script src = "<%=prj%>/js/shop_header.js"></script>
<script src = "<%=prj%>/js/shop_search.js"></script>
<jsp:useBean id = "userDAO" class = "shop.ShopUserDAO"/>
<%
String user_id = (String)session.getAttribute("user_id");
ShopUserDTO userDTO = userDAO.myPageChk(user_id);
%>
</head>
<body onload = "headerInit()">
	<form method = "get" action = "<%=headerContext%>/CtrlHeader.do">
	<input type = "hidden" name = "page" value = "pageSearch" id = "page">
	<%--검색어 입력 시 연관성있는 상품명 생성.
	onchange 이벤트로 리스트 생성--%><input type = "hidden" id = "itemLists">
	<div class="header">
		<div class="menu" onclick="mMenu()"></div>
		<div class="select">
			<table>
				<tr>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=outer'"><img src="<%=prj%>/img/icon/coat.png">겉옷</td>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=shirt'"><img src="<%=prj%>/img/icon/clothes.png">상의</td>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=pants'"><img src="<%=prj%>/img/icon/pants.png">하의</td>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=shoe'"><img src="<%=prj%>/img/icon/shoe.png">신발</td>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=bag'"><img src="<%=prj%>/img/icon/bag.png">가방</td>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=phone'"><img src="<%=prj%>/img/icon/phone.png">휴대폰</td>
					<td onclick = "location.href = '<%=headerContext%>/CtrlPd.do?page=pageCategory&category=watch'"><img src="<%=prj%>/img/icon/watch.png">시계</td>
				</tr>
			</table>
		</div>
		<div class="logo" onclick = "header('pageMain')"></div>
		<!-- 
		<input type="text" name = "search" id = "search" placeholder="검색어를 입력하세요."
		onkeydown = "mEnterSearch(event.keyCode)" onkeyup = "autoCompleteName('<%=headerContext%>', this)">
		<ul id = "items"></ul>
		<img src="<%=prj%>/img/icon/search.png" id = "searchIcon" onclick = "mSearch()">
		 -->
		<fieldset>
			<input type="text" autocomplete = "off" name = "search" id = "search" placeholder="검색어를 입력하세요."
			onkeydown = "mEnterSearch(event.keyCode)" onkeyup = "autoCompleteName('<%=headerContext%>', this)">
			<img src="<%=prj%>/img/icon/search.png" id = "searchIcon" onclick = "mSearch()">
			<ul id = "items"></ul>
		</fieldset>
		<%
		if (user_id != null) {
		%>
		<div class="logout" onclick = "header('pageLogout')">로그아웃</div>
		<div class="myPage" onclick = "header('pageMy')">내 정보</div>
		<div class="bag" onclick = "header('pageCart')">장바구니</div>
		<%
			if(userDTO.getUser_rank().contains("판매자")){
			%>
			<div class = "seller" onclick = "header('pageRaiseProduct')">상품등록</div>
			<%
			}
		} else {
		%>
		<div class="login" onclick = "header('pageLog')">로그인</div>
		<%
		}
		%>
		<div id = "notification" onclick = "header('pageNotification')">공지사항</div>
	</div>
	</form>
</body>
</html>