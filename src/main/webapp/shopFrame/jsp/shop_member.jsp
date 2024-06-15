<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
  String phone = request.getParameter("shop_phone");
	request.setCharacterEncoding("utf-8");
	String msg = request.getParameter("msg");
	String contextPath = request.getContextPath();
	//control
	String realPath = contextPath + "/CtrlMember.do";
	//css
	String cssPath = contextPath + "/shopFrame/css/shop_member.css";
	//javaScript
	String javaScriptPath = contextPath + "/shopFrame/js/shop_member.js";
	//img
	String imgPath1 = contextPath + "/shopFrame/img/icon/search.png";
	String imgPath2 = contextPath + "/shopFrame/img/logo.png";
  %>
<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="<%=cssPath%>">
  <script src="<%=javaScriptPath%>"></script>
 
 </head>
 <body onLoad="mInit()">
  <div id="wrapper">
  <form method="post" action="<%=realPath%>">
  
  <input type="hidden" name="user_id" id="Log_Id" value="">
  <input type="hidden" name="user_pwd" id="Log_Pwd" value="">
  <input type="hidden" name="user_name" id="Log_name" value="">
  <input type="hidden" name="user_email" id="Log_email" value="">
  <input type="hidden" name="user_phone" id="Log_phone" value="">
  <input type="hidden" name="user_addr" id="Log_addr" value="">
  <input type="hidden" name="user_rank" id="Log_rank" value="">
  <input type="hidden" name="user_cate" id="user_cate" value="phone">
  <input type="hidden" value="" name="page" id="page">
  
	<div class="header">
		<div class="logo" onclick = "controlSend('pageMain')"><img src = "<%=imgPath2%>"></div>
		<div class="nav1">
			<p>고객센터</p>
			<p>마이페이지</p>
			<p>관심</p>
			<p>알림</p>
			<p>로그인</p>
		</div>
		<div class="nav2">
			<p>HOME</p>
			<p>STYLE</p>
			<p>SHOP</p>
			<img src="<%=imgPath1%>">
		</div>
	</div>
	<div class="main">
		<h1>회원가입</h1>
		<div class="member">
			<!-- 1 --><p>아이디</p>
			<!-- 2 --><input type="text" id="Id" placeholder="영문 , 숫자 조합 8자">

			<!-- 3 --><p>비밀번호</p>
			<!-- 4 --><input type="password" id="Pwd" placeholder="영문 , 숫자 , 특수문자(!,&,@) 조합 8 ~ 16자">
			
			<!-- 5 --><p>이름</p>
			<!-- 6 --><input type="text" id="name" placeholder="예 ) 홍길동">
			
			<!-- 7 --><p>이메일 주소</p>
			<!-- 8 --><input type="text" id="email" placeholder="예 ) dream@test.com">

			<!-- 9 --><p>전화번호</p>
			<!-- 10 --><input type="text" id="phone" placeholder="전화번호를 입력하세요" value="<%=phone%>" disabled>

			<!-- 11 --><p>주소</p>
			<!-- 12 --><input type="text" id="addr" placeholder="주소를 입력하세요">
			
			<!-- 13 --><p>유형</p>
			<!-- 14 --><input type="text" id="rank" placeholder="판매자 / 구매자">

			<!-- 15 --><input type="checkbox" id="chkbox1">
			<!-- 16 --><label for="chkbox1">[필수]만 14세 이상이며 모두 동의합니다.</label>
			<!-- 17 --><input type="checkbox" id="chkbox2">
			<!-- 18 --><label for="chkbox2">[선택]광고성 정보 수신에 동의합니다.</label>
			<!-- 19 --><input type="button" value="회원가입" onclick="mSend()">
			<%
			request.getSession().removeAttribute("phone");
			%>
		</div>
	</div>
	</form>
  </div>
 </body>
</html>