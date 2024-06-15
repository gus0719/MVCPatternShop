<%@page import="shop.ShopUserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
request.setCharacterEncoding("utf-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
ShopUserDTO userDTO = (ShopUserDTO)request.getAttribute("userDTO"); // 유저의 정보 반환
%>
<head>
    <meta charset="UTF-8">
    <title>상품등록</title>
    <link rel = "stylesheet" href = "<%=prjPath%>/css/shop_raiseProduct.css">
    <link rel = "stylesheet" href = "<%=prjPath%>/css/shop_explain.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <script src = "<%=prjPath%>/js/shop_raiseProduct.js"></script>
    <script src = "<%=prjPath%>/js/shop_explain.js"></script>
</head>
<body style = "overflow-x : hidden">
    <div id="container">
        <img id = "logo" src = "<%=prjPath%>/img/logo.png" onclick = "location.href = '<%=contextPath%>/CtrlPd.do?page=pageMain'">
        <p id = "title">상품 등록</p>
        <form method = "post" action = "<%=contextPath%>/CtrlPd.do">
        	<input type = "hidden" name = "page" value = "proRaiseProduct">
            <table>
                <colgroup>
                    <col span = "1" style = "background-color : #eeeeee">
                </colgroup>
                <tr>
                    <td class = "info">상품명</td>
                    <td class = "inputs">
                        <input type = "text" id = "product_name" name = "product_name" onchange = "viewName(this)" required = "required">
                    </td>
                </tr>
                <tr>
                    <td class = "info">카테고리</td>
                    <td class = "inputs">
                        <select name = "product_category" id = "product_category" onchange = "getCategory(), showAddImages(this)">
                            <option value = "no" selected>카테고리를 선택하세요</option>
                            <option value = "outer">아우터</option>
                            <option value = "shirt">셔츠</option>
                            <option value = "pants">하의</option>
                            <option value = "shoe">신발</option>
                            <option value = "bag">가방</option>
                            <option value = "phone">휴대폰</option>
                            <option value = "watch">시계</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class = "info">브랜드</td>
                    <td class = "inputs">
                        <input type = "text" id = "product_brand" name = "product_brand" required = "required">
                    </td>
                </tr>
                <tr>
                    <td class = "info">가격</td>
                    <td class = "inputs">
                        <input type = "number" id = "product_price" name = "product_price" onchange = "viewPrice(this)"
                        required = "required">
                    </td>
                </tr>
                <tr>
                    <td class = "info">설명</td>
                    <td class = "inputs">
                        <textarea id = "product_explain" name = "product_explain" onchange = "viewExplain(this)"
                        required = "required"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class = "info">판매자</td>
                    <td class = "inputs">
                        <input type = "text" id = "product_seller" name = "product_seller" value = "<%=userDTO.getUser_name()%>" readonly>
                    </td>
                </tr>
                <tr>
                    <td class = "info">이미지</td>
                    <td class = "inputs">
                        <input type = "file" id = "product_img" multiple onchange = "getImages(), viewImg('<%=prjPath%>')" alt = "pd_img.value"
                        required = "required">
                        <input type = "hidden" name = "product_img" id = "pd_img" value = "">
                    </td>
                </tr>
            </table>
	    </div>
	    <div id = "wrapper"><!-- 미리보기 ----------------->
	        <p id = "title">상품 미리보기</p>
	        <div id = "explain_top">
	            <section>
	                <div id = "explain_top_mainImg">
	                    <img>
	                </div>
	                <div id = "explain_top_subImg">
	                    <!-- 이미지 추가
	                    <img class="explain_top_subImg_dots">
	                    <img class="explain_top_subImg_dots">
	                    -->
	                </div>
	            </section>
	            <aside>
	                <div id = "explain_product">
	                    <h4>구매가</h4>
	                    <p id = "explain_price"></p>
	                    <p id = "explain_name"></p>
	                    <select name = "size" id = "product_list">
	                        <option value = "no" selected>옵션 선택</option>
	                        <option value = "L">L 사이즈</option>
	                        <option value = "XL">XL 사이즈</option>
	                        <option value = "XXL">XXL 사이즈</option>
	                    </select>
	                    <div id = "product_info">
                            <textarea rows = "5" cols = "30" readonly></textarea>
                        </div>
	                    <div id = "product_buy">구매</div>
	                    <div id = "product_cart">장바구니</div>
	                    <div id = "product_interest">관심상품
	                        <span class="material-symbols-outlined" id = "keep">keep</span>
	                    </div>
	                </div>
	            </aside>
	        </div>
	        <div id = "explain_images">
	            <!--이미지 추가-->
	        </div>
	        <div id = "btnRegion">
			    <button type = "submit">상품 등록</button><%-- raiseProduct_pro.jsp 페이지로 이동해서 처리 --%>
				<button type = "button">취소</button>
			</div>
		</form>
    </div>    
</body>
</html>