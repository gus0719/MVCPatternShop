<%@page import="java.util.ArrayList"%>
<%@page import="shop.ShopProductDTO"%>
<%@page import="shop.ShopProductDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";

DecimalFormat noFormat = new DecimalFormat();
String search = "";
ArrayList<ShopProductDTO> product = (ArrayList<ShopProductDTO>)request.getAttribute("searchList");
String size = Integer.toString(product.size());
String img[] = new String[Integer.parseInt(size)];
String name[] = new String[Integer.parseInt(size)];
String brand[] = new String[Integer.parseInt(size)];
int price[] = new int[Integer.parseInt(size)];

if (product.size() == 0) {
	img = new String[] { "" };
	name = new String[] { "" };
	brand = new String[] { "" };
	price = new int[] { 0 };
	size = "0";
	search = "검색 결과가 존재하지 않습니다.";
} else {
	for (int i = 0; i < product.size(); i++) {
		img[i] = product.get(i).getProduct_img();
		name[i] = product.get(i).getProduct_name();
		price[i] = product.get(i).getProduct_price();
		brand[i] = product.get(i).getProduct_brand();
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search.html</title>
<link rel="stylesheet" href="<%=prjPath%>/css/shop_search.css">
<link rel="stylesheet" href="<%=prjPath%>/css/shop_headerContainer.css">
<script src="<%=prjPath%>/js/shop_search.js"></script>
</head>
<body>
	<div id = "container">
	<!-- 헤더 부분 -->
		<%@ include file="./shop_header.jsp"%>
	</div>
	<div id="wrapper">
		<form method="get">
			<input type = "hidden" name = "page" value = "pageExplain">
			<input type = "hidden" id="size" name="size" value="<%=size%>">
			<input type = "hidden" name = "product_code" id = "product_code" value = "">
			<!-- 메인 부분 -->
			<div class="main">
				<h1>
					검색 결과 :
					<%=search%></h1>
				<p>
					검색 수 :
					<%=size%></p>
				<br>
				<hr>
				<br>
				<%
				for (int i = 0; i < Integer.parseInt(size); i++) {
					String[] imgArr = img[i].substring(img[i].indexOf("[") + 1, img[i].lastIndexOf("]")).split(",");
				%>
				<div class="productMain" onclick = "goWithProductCode('<%=contextPath%>', <%=product.get(i).getProduct_code()%>)">
					<img class="productImg" src = "<%=prjPath%>/img<%=imgArr[0]%>">
					<div class="productBrand"><%=brand[i]%></div>
					<div class="productName"><%=name[i]%></div>
					<div class="productPrice"><%=noFormat.format(price[i])%>원</div>
				</div>
				<%
				}
				%>
			</div>
		</form>
	</div>
</body>
</html>