<%@page import="java.net.URLEncoder"%>
<%@page import="shop.ShopNotificationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="./../css/shop_headerContainer.css">
<link rel="stylesheet" href="./../css/shop_notification.css">
<jsp:useBean id="dao" class="shop.ShopNotificationDAO" />
<%
request.setCharacterEncoding("utf-8");
String notification_No = request.getParameter("notification_No");
ShopNotificationDTO dto = new ShopNotificationDTO();
dto = dao.bodSelect(Integer.parseInt(notification_No));
String contextPath = request.getContextPath();
%>
</head>
<body>
	<div id="container">
		<%@ include file="./shop_header.jsp"%>
	</div>
	<div id="wrapper">
		<h1>공지사항</h1>
		<div class="blackstick"></div>
		<div class="notification_head">
			<Strong class="sort"><%=dto.getNotification_Subject()%></Strong>
			<div class="title_box">
				<p class="right">
					작성일자 :
					<%=dto.getNotification_Date()%></p>
			</div>
		</div>
		<div class="notification_content">
			<div class="content">
				<%=dto.getNotification_Content()%>
			</div>
		</div>
		<div class="buttons">
			<a class="buts"
				href="<%=contextPath%>/CtrlNotification.do?notification_No=<%=notification_No%>&page=updateChk">수정</a>
			<a class="buts"
				href="<%=contextPath%>/CtrlNotification.do?notification_No=<%=notification_No%>&page=delete">삭제</a>
			<a class="buts" href="<%=contextPath%>/CtrlNotification.do?page=pageNotification">목록보기</a>
		</div>
	</div>

</body>
</html>