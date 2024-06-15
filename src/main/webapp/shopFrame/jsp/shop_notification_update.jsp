<%@page import="java.net.URLEncoder"%>
<%@page import="shop.ShopNotificationDTO"%>
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
	<link rel = "stylesheet" href = "./../css/shop_headerContainer.css">
    <link rel = "stylesheet" href = "./../css/shop_notification.css">
    <link rel = "stylesheet" href = "<%=cssConPath%>">
    <link rel = "stylesheet" href = "<%=cssMainPath%>">
    
<%
request.setCharacterEncoding("utf-8");
String notification_No = request.getParameter("notification_No");

ShopNotificationDTO dto= new ShopNotificationDTO();
dto = (ShopNotificationDTO)request.getAttribute("dto");

%>
</head>
<body>
	<div id="container">
		<%@ include file="./shop_header.jsp"%>
	</div>
	<div id="wrapper">
	<form action="<%=contextPath%>/CtrlNotification.do">
	<input type = "hidden" name = "page" value = "update">
		<h1>공지사항 수정하기</h1>
		<div class="blackstick"></div>
		<div class="notification_head">
		<input type="hidden" name="notification_No" value=<%=notification_No %>>
			<p>			
			
				제목 : <input type="text" name="notification_Subject"	value="<%=dto.getNotification_Subject() %>">
			
			</p>
		</div>
		<div class="notification_content">
			<div class="content">				
				<textarea class="contentwrite" name="notification_Content" rows=10 cols=40 placeholder="내용을 입력하세요"><%=dto.getNotification_Content() %></textarea>
			</div>
		</div>
        <div class="buttons">
            <button type="submit" class="buts">수정</button>            
            <a class="buts" href="<%=contextPath%>/CtrlNotification.do?page=pageNotification">목록보기</a>
        </div>
        </form>
    </div>        
</body>
</html>