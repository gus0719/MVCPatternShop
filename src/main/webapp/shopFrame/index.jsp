<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>4조6조 쇼핑몰프로젝트</title>
<%
request.setCharacterEncoding("utf-8");
String contextPath = request.getContextPath();
%>
</head>
<body>
<% // 메인 페이지 이동
response.sendRedirect(contextPath+"/CtrlPd.do?page=pageMain");
%>
</body>
</html>