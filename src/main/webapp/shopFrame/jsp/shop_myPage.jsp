<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="shop.ShopUserDAO" %>
<%@ page import="shop.ShopUserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <%
  ShopUserDAO dao = new ShopUserDAO();
  ShopUserDTO dto = new ShopUserDTO();
  
  request.setCharacterEncoding("UTF-8");
  String contextPath = request.getContextPath();
  String prjPath = contextPath + "/shopFrame";
  dto = (ShopUserDTO)request.getSession().getAttribute("myPageDTO");
  ArrayList<Object> myPage = (ArrayList<Object>)request.getSession().getAttribute("myPage");
  String rank1 = (String)myPage.get(0);
  String rank2 = (String)myPage.get(1);
  String userDel = (String)myPage.get(2);
  %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="<%=prjPath%>/css/shop_myPage.css">
	<script src="<%=prjPath%>/js/shop_myPage.js"></script>
</head>
<body onLoad="mInit()">
<%--
세션에 저장된 user_id의 속성값을 받아서 고객에 대한 정보 출력 알고리즘 작성
--%>
	<div id="wrapper">
		<form action="<%=contextPath%>/CtrlMember.do">
		<input type="hidden" id="checkbox" name="checkbox" value="<%=rank2%>">
		<input type="hidden" id="column" name="column" value="">
		<input type="hidden" id="up_column" name="up_column" value="">
		<input type="hidden" id="userDel" name="userDel" value="<%=userDel%>">
		<input type="hidden" id="check" name="check" value="<%=rank2 %>">
		<input type="hidden" name="page" value="pageMy">
		<input type="hidden" id="user_id" name="user_id" value="">

			<div class="header">
				<div class="logo"><img src="<%=prjPath%>/img/logo.png" onclick="location.href='<%=contextPath%>/CtrlPd.do?page=pageMain'"></div>
				<div class="nav1">
					<p>고객센터</p>
					<p>마이페이지</p>
					<p>관심</p>
					<p>알림</p>
					<p>로그인</p>
				</div>
				<div class="nav2">
					<p>HOME</p>
					<p onclick = "location.href = '<%=contextPath%>/CtrlPd.do?page=pageBuyList'">STYLE</p>
					<p>SHOP</p>
					<img src="<%=prjPath%>/img/icon/search.png">
				</div>
			</div>
			<div class="main">
				<h1>로그인 정보</h1>

				<h3>내 계정   유형 : <%=rank1 %></h3>
				<!-- 아이디 및 비밀번호 -->
				<p>아이디</p> <!-- 변경 X -->
				<div><input type="text" id="id" class="txt" value="<%=dto.getUser_id() %>" disabled></input><%--<input type="button" value="변경" onclick="mChange(1)">--%></div>

				<p>비밀번호</p>
				<div><input type="text" class="txt" value="<%=dto.getUser_pwd() %>" disabled><input type="button" value="변경" onclick="mChange(2)"></div>

				<h3>개인 정보</h3>
				<!-- 이름 , 이메일 , 휴대폰 , 주소 -->
				<p>이름</p>
				<div><input type="text" class="txt" value="<%=dto.getUser_name() %>" disabled><input type="button" value="변경" onclick="mChange(3)"></div>
				
				<p>이메일</p>
				<div><input type="text" class="txt" value="<%=dto.getUser_email() %>" disabled><input type="button" value="변경" onclick="mChange(4)"></div>

				<p>휴대폰</p>
				<div><input type="text" class="txt" value="<%=dto.getUser_phone() %>" disabled><input type="button" value="변경" onclick="mChange(5)"></div>

				<p>주소</p>
				<div><input type="text" class="txt" value="<%=dto.getUser_addr()%>" disabled><input type="button" value="변경" onclick="mChange(6)"></div>

				<h4>광고성 정보 동의</h4>
				<!-- 광고의 문자 메세지 동의와 이메일 동의를 합침 -->
				<div class="chk1">문자 메세지 및 이메일
					<label for="msgtrue" onclick="check('true')">수신동의</label>
					<input type="radio" id="msgtrue" name="msg" onclick="check('true')">
					<label for="msgfalse" onclick="check('false')">수신거부</label>
					<input type="radio" id="msgfalse" name="msg" onclick="check('false')">
				</div>
				<br>
				<span onclick="userDel()">회원탈퇴</span>
			</div>
		</form>
	</div>
</body>
</html>