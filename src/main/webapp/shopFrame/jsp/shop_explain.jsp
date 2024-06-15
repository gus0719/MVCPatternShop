<%@page import="java.util.HashMap"%>
<%@ page import = "shop.ShopProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
String pagePath = contextPath + "/CtrlPd.do";
HashMap<String, Object> explainMap = (HashMap<String, Object>)request.getAttribute("explainMap");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel = "stylesheet" href = "<%=prjPath%>/css/shop_headerContainer.css">
    <link rel = "stylesheet" href = "<%=prjPath%>/css/shop_explain.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <script src = "<%=prjPath%>/js/shop_explain.js"></script>
    <script src = "<%=prjPath%>/js/shop_explain_wiki.js"></script>
    <%
    /* 상품 끌어오기 =========================================
    */
    String product_code = request.getParameter("product_code");
    ShopProductDTO product = new ShopProductDTO();
    
   	product = (ShopProductDTO)explainMap.get("explainDTO"); // 상품코드의 상품 반환
    
    // 이미지 문자열 배열로 쪼개기
    String mainImg = product.getProduct_img();
    mainImg = mainImg.substring(
    		mainImg.indexOf("[")+1, mainImg.lastIndexOf("]")
    ).split(",")[0];
    
    /* 관심상품 상태 끌어오기
     * 1이면 있음. 0이면 없음.
    */
    int interestState = (Integer)explainMap.get("interestState");
    
    /* 위키 텍스트 끌어오기
    */
    String wiki_text = (String)explainMap.get("wiki_text");
    if(wiki_text == null)
    	wiki_text = "";
    %>
    <title><%= product.getProduct_name() %></title>
</head>
<body onload = "mInit('<%=contextPath%>'), iState(<%=interestState%>), wikiInit()">
	<div id = "container">
	    <%@ include file = "./shop_header.jsp" %>
    </div>
    <div id = "wrapper">
        <form method = "get" action = "<%=pagePath%>">
			<!-- 데이터 임시 저장 -->
			<input type = "hidden" name = "page" id = "pagePd">
			<input type = "hidden" id = "productImg" value = "<%= product.getProduct_img()%>">
			<%--메인이미지--%><input type = "hidden" name = "product_img" id = "product_img" value = "<%= mainImg%>">
			<%--상품코드--%><input type = "hidden" name = "product_code" id = "product_code" value = "<%= product.getProduct_code()%>">
			<%--상품가격--%><input type = "hidden" name = "product_price" id = "price" value = "<%= product.getProduct_price()%>">
			<%--상품명--%><input type = "hidden" name = "product_name" id = "pdname" value = "<%= product.getProduct_name()%>">
			<%--위키--%><input type = "hidden" id = "wiki" value = "<%= wiki_text%>">
			<%--장바구니관심상품삭제--%><input type = "hidden" name = "msg" id = "message">
	        <div id = "explain_top">
	            <section>
	                <div id = "explain_top_mainImg">
	                    <img>
	                    <span class="material-symbols-outlined" id = "prev" onclick = "prevNextBtn(-1)">chevron_left</span>
	                    <span class="material-symbols-outlined" id = "next" onclick = "prevNextBtn(1)">chevron_right</span>
	                </div>
	                <div id = "explain_top_subImg">
	                </div>
	            </section>
	            <aside>
	                <div id = "explain_product">
	                    <h4>구매가</h4>
	                    <p id = "explain_price"></p>
	                    <p id = "explain_name"></p>
	                    <select name = "size" id = "product_list">
	                    	<%
	                    	if(product.getProduct_category().equals("shoe")){
	                    	%>
	                    	<option value = "no" selected>발사이즈 선택</option>
	                    	<option value = "250">250mm</option>
	                    	<option value = "260">260mm</option>
	                    	<option value = "270">270mm</option>
	                    	<option value = "280">280mm</option>
	                    	<option value = "290">290mm</option>
	                    	<%
	                    	} else {
	                    	%>
	                        <option value = "no" selected>옵션 선택</option>
	                        <option value = "L">L 사이즈</option>
	                        <option value = "XL">XL 사이즈</option>
	                        <option value = "XXL">XXL 사이즈</option>
	                        <%
	                    	}
	                        %>
	                    </select>
	                    <div id = "product_info">
	                        <textarea rows = "5" cols = "30" readonly><%= product.getProduct_explain() %></textarea>
	                    </div>
	                    <div id = "product_count">
	                    	수량<input type = "number" name = "product_count" id = "product_count_field" value = "1" onchange = "countChk(this)">√
	                    </div>
	                    <div id = "product_buy" onclick = "goToBuyPage()">구매</div><%--클릭 시 상품 정보들을 hidden에 담아서 구매페이지로 서밋--%>
	                    <div id = "product_cart" onclick = "putItemOnCart()">장바구니</div>
	                    <input type = "hidden" id = "interestState" value = "<%=interestState%>">
	                    <div id = "product_interest" onclick = "manageInterest('<%=contextPath%>', interestState)">관심상품
	                        <span class="material-symbols-outlined" id = "keep">keep</span>
	                    </div>
	                </div>
	            </aside>
	        </div>
	        <nav id = "explain_navi">
	            <a href = "#explain_images" class = "explain_bookmark">상품 상세정보</a>
	            <a href = "#explain_wiki" class = "explain_bookmark">스타일 위키</a>
	            <a href = "#explain_like" class = "explain_bookmark">연관 상품</a>
	        </nav>
	        <div id = "explain_images">
	            <!--이미지 추가-->
	        </div>
	        <div id = "explain_info">
	            <table id = "info_table">
	                <caption>사이즈 정보</caption>
	                <tr>
	                    <th>L 사이즈</th>
	                    <th>XL 사이즈</th>
	                    <th>XXL 사이즈</th>
	                </tr>
	                <tr>
	                    <td></td>
	                    <td></td>
	                    <td></td>
	                </tr>
	            </table>
	        </div>
	        <div id = "explain_wiki">
	            <p class = "title">스타일 위키</p>
	            <textarea id = "wiki_text" name = "wiki_text" rows = "20" cols = "100" readonly></textarea>
	            <%
	            if(session.getAttribute("user_id") != null) {
	            %>
	            <span id = "wikiBtn" onclick = "enableWiki()">입력</span><%--클릭 시 readonly = false--%>
	            <span id = "updateWikiBtn" onclick = "updateWiki()">변경</span><%--클릭 시 상품코드, 상품명, 위키텍스트를 hidden에 담아서 wiki_pro 페이지로 서밋--%>
	            <%
	            }
	            %>
	        </div>
	        <div id = "explain_like">
	            <p class = "title">연관 상품</p>
	        </div>
        </form>
    </div>
</body>
</html>