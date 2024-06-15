<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "shop.ShopUserDTO" %>
<%@ page import = "shop.ShopBuyDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
HashMap<String, Object> orderMap = (HashMap<String, Object>)request.getAttribute("orderMap");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta data-n-head="ssr" data-hid="viewport" name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <title>주문완료</title>
    <link href="<%=prjPath%>/css/shop_order.css" rel="stylesheet">
    <%
    DecimalFormat noFormat = new DecimalFormat(); // 가격 포멧
    ShopUserDTO userDTO = (ShopUserDTO)orderMap.get("userDTO"); // 유저의 정보 반환
    String msg = (String)orderMap.get("msg");
    %>
</head>
<body onload = "alert('<%=msg%>')">
    <div id="__layout"><!-- 전체 설정-->
        <div class="wrapper" tabindex="0">
            <div></div>
            <div class="container"><!-- 전체 배경색 -->
                <div class="content">
                    <div class="white">
                        <div class="title">
                            <h3>주문완료</h3>
                        </div>
                        <div class="buy">
                            <strong>주문이 완료되었습니다.</strong>감사합니다!
                        </div>
                        <div class="info">
                            <h3>상품배송 정보</h3>
                            <div class="delivery">
                                <p id="arrive">다음 주 금요일 도착 예정</p>
                            </div>
                            <h4 class="blank">받는 사람 정보</h4>
                            <table class="userinfo">
                                <tr>
                                    <td>받는사람</td>
                                    <td><%= userDTO.getUser_name() %> / <%= userDTO.getUser_phone() %></td>
                                </tr>
                                <tr>
                                    <td>받는주소</td>
                                    <td><%= userDTO.getUser_addr() %></td>
                                </tr>
                                <tr>
                                    <td>배송요청사항</td>
                                    <td>문앞에 두고 가주세요</td>
                                </tr>
                            </table>
                        </div>
                        <div class="buts">
                            <div class="leftt">
                                <input type="button" class="sangse" value="주문 상세보기">
                                <input type="button" class="shoping" value="쇼핑 계속하기" onclick = "location.href = '<%=contextPath%>/CtrlPd.do?page=pageMain'">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>