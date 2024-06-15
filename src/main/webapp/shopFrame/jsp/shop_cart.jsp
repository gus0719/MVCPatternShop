<%@ page import = "java.text.DecimalFormat"%>
<%@ page import = "shop.ShopCartDTO"%>
<%@ page import = "shop.ShopProductDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
DecimalFormat numberFormat = new DecimalFormat(); // 숫자 자리수 구분
HashMap<String, Object> cartMap = (HashMap<String, Object>)request.getAttribute("cartMap");
List<ShopCartDTO> items = (List<ShopCartDTO>)cartMap.get("items");
List<ShopProductDTO> cartList = (List<ShopProductDTO>)cartMap.get("cartList");
String cartMsg = request.getParameter("msg");
%>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel = "stylesheet" href = "<%=prjPath%>/css/shop_headerContainer.css">
<link rel = "stylesheet" href = "<%=prjPath%>/css/shop_cart.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">

<script src = "<%=prjPath%>/js/shop_cart.js"></script>
</head>
<body onload = "mInit()">
	<div id = "container">
	    <%@ include file = "./shop_header.jsp" %>
    </div>
    <main id = "wrapper">
        <p id = "title">장바구니</p>
        <form method = "get" action = "<%=contextPath%>/CtrlPd.do">
        	<input type = "hidden" name = "page" id = "pagePd">
        	<%--구매, 삭제, 설명에 전달할 값--%>
        	<input type = "hidden" name = "msg" value = "cart">
        	<input type = "hidden" name = "product_img" id = "sendImg">
            <input type = "hidden" name = "size" id = "sendSize">
            <input type = "hidden" name = "product_code" id = "sendCode">
            <input type = "hidden" name = "product_count" id = "sendCount">
            <input type = "hidden" name = "product_name" id = "sendName">
            <div id="cart">
                <ul id="cart_items">
                <%
                for(int idx = 0; idx < cartList.size(); idx++){
                	ShopProductDTO productDTO = cartList.get(idx);
                	int price;
                	String msg = "";
                	String imgText = productDTO.getProduct_img();
                	String[] imgArr = imgText.substring(
                			imgText.indexOf("[") + 1, imgText.lastIndexOf("]")
                	).split(",");
                	if(productDTO == null){
                		msg = "삭제된 상품";
                	} else {
                		// 상품 가격 x 수량
                		price = productDTO.getProduct_price() * items.get(idx).getCart_num();
                		msg = numberFormat.format(price) + "원";
                	}
                %>
                    <li>
                        <img onclick = "goExplain(<%= productDTO.getProduct_code()%>, '<%= msg%>')" src = "<%=prjPath%>/img<%=imgArr[0]%>">
                        <span class = "items_name"><%= items.get(idx).getCart_product_name() %> X <%= items.get(idx).getCart_num() %></span>
                        <span class = "items_price"><%= msg %></span>
                        <%
                        if(productDTO != null){
                        %>
                        <span id = "buyBtn" class = "material-symbols-outlined" onclick = "buyNow(<%= productDTO.getProduct_code() %>, <%=idx%>, '<%=imgArr[0]%>')">shop</span>
                        <%
                        }
                        %>
                        <span id = "cartDel" class = "material-symbols-outlined" onclick = "deleteItem(<%= productDTO.getProduct_code()%>)">delete</span>
                    </li>
                <%
                }
                %>
                </ul>
            </div>
        </form>
    </main>
</body>
</html>