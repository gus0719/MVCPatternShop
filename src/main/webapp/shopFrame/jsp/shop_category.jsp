<%@ page import="java.util.List"%>
<%@ page import="shop.ShopProductDTO"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
HashMap<String, Object> categoryMap = (HashMap<String, Object>) request.getAttribute("categoryMap");
%>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link rel="stylesheet" href="<%=prjPath%>/css/shop_headerContainer.css">
<link rel="stylesheet" href="<%=prjPath%>/css/shop_category.css">
<script src="<%=prjPath%>/js/shop_category.js"></script>
<%
// 카테고리 =================
String product_category = request.getParameter("category");
//브랜드 =======
String product_brand = request.getParameter("brand");

List<String> brands = (List<String>) categoryMap.get("brands"); // 브랜드 출력, distinct 브랜드

List<ShopProductDTO> items = (List<ShopProductDTO>) categoryMap.get("items"); // 카테고리와 일치하는 상품들 반환

// 숫자 형식 변환
DecimalFormat noFormat = new DecimalFormat();
%>
</head>
<body>
	<div id="container">
		<%@ include file="./shop_header.jsp"%>
	</div>
	<div id="wrapper">
		<div class="categoryTop">
			<div class="cateLocation">
				<%
				for (int i = 0; i < brands.size(); i++) {
				%>
				<div class="brand"
					onclick="selectBrand('<%=contextPath%>', '<%=product_category%>', '<%=brands.get(i)%>')"><%=brands.get(i)%></div>
				<%
				}
				%>
			</div>
		</div>
		<form method="get">
			<input type="hidden" name="page" id="pagePd" value="pageExplain">
			<input type="hidden" name="product_code" id="product_code">
			<div class="product">
				<ul id="cart_items">
					<%-- 상품 출력 ================================================== --%>
					<%
					for (int idx = 0; idx < items.size(); idx++) {
						String imgArrText = items.get(idx).getProduct_img();
						String[] imgArr = imgArrText.substring(imgArrText.indexOf("[") + 1, imgArrText.lastIndexOf("]")).split(","); // 배열 이미지 추출
					%>
					<li	onclick="goWithProductCode('<%=contextPath%>', '<%=items.get(idx).getProduct_code()%>')">
						<img src="<%=prjPath%>/img<%=imgArr[0]%>">
						<span class="items_name"><%=items.get(idx).getProduct_name()%></span>
						<span class="items_price"><%=noFormat.format(items.get(idx).getProduct_price()) + "원"%></span>
					</li>
					<%
					}
					%>
				</ul>
			</div>
		</form>
	</div>
</body>
</html>