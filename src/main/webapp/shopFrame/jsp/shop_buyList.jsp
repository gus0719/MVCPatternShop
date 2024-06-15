<%@ page import = "java.util.List" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "shop.ShopBuyDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
DecimalFormat noFormat = new DecimalFormat();
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
List<ShopBuyDTO> buyList = (List<ShopBuyDTO>)request.getAttribute("buyList");
%>
<html>
<head>
<meta charset="UTF-8">
<title>구매내역</title>
<link rel = "stylesheet" href = "<%=prjPath%>/css/shop_buyList.css">
<link rel = "stylesheet" href = "<%=prjPath%>/css/shop_headerContainer.css">
<%
request.setCharacterEncoding("utf-8");
%>
</head>
<body>
	<%-- 헤더 영역 --%>
	<div id = "container">
	    <%@ include file = "./shop_header.jsp" %>
    </div>
    <main id = "wrapper">
    	<p id = "title">구매내역</p>
    	<ul id = "buy_list">
    		<%
    		for(int idx = 0; idx < buyList.size(); idx++){
    			ShopBuyDTO buyProduct = buyList.get(idx);
    		%>
		    <li>
		    	<img id = "product_img" src = "<%=prjPath%>/img<%=buyProduct.getBuy_productimg()%>">
		    	<div id = "product_info">
			    	<span id = "product_name">상품명 : <%=buyProduct.getBuy_productname() %></span><br>
			    	<span id = "product_price">가격 : <%=noFormat.format(buyProduct.getBuy_price())%>원</span><br><br>
			    	<span id = "user_address">주소 : <%=buyProduct.getBuy_addr() %></span>
		    	</div>
		    </li>
		    <%
    		}
		    %>
    	</ul>
    </main>
</body>
</html>