<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
request.setCharacterEncoding("UTF-8");
String contextP = request.getContextPath();
String prj2 = contextP + "/shopFrame";
%>
<head>
<meta charset="UTF-8">
<link rel = "stylesheet" href = "<%=prj2%>/css/shop_footer.css">
<title>Insert title here</title>
</head>
<body>
	<div id = "footer">
		<section id = "footerLeft">
			<img src = "<%=prj2%>/img/logo.png">
			<strong>(주) 드림</strong>
			<p>위치 : 서울시 노원구 초안산로<br>
			ⓒCopyright Team4&6 All Time Reserved</p>
		</section>
		<aside id = "footerRight">
			<a href = "#">회사소개</a>
			<a href = "#">개인정보 처리방침</a>
			<a href = "#">이용약관</a>
		</aside>
	</div>
</body>
</html>