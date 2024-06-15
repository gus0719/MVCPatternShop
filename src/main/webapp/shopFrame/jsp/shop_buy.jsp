<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.HashMap" %>
<%@ page import="shop.ShopProductDTO"%>
<%@ page import = "shop.ShopUserDTO" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
response.setCharacterEncoding("utf-8");
String contextPath = request.getContextPath();
String prjPath = contextPath + "/shopFrame";
HashMap<String, Object> buyMap = (HashMap<String, Object>)request.getAttribute("buyMap");
%>
<html lang="ko"
	style="--vh: 8.66px; --global-header-height: 65.96875px;">

<head>
<meta data-n-head="ssr" charset="utf-8">
<meta data-n-head="ssr" data-hid="viewport" name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, viewport-fit=cover">

<link href="<%=prjPath%>/css/shop_buy.css" rel="stylesheet" type="text/css">
<%
/* 로그인 확인 ===========================
*/
String user_id = (String)session.getAttribute("user_id");
ShopUserDTO userDTO = new ShopUserDTO();
if(user_id == null){ // 로그인 상태 아니면 로그인 페이지로 이동
	String msg = "로그인이 필요한 서비스입니다.";
	response.sendRedirect(contextPath+"/CtrlMember.do?page=pageLog&msg="+URLEncoder.encode(msg, "utf-8"));
} else {
	userDTO = (ShopUserDTO)buyMap.get("userDTO");
}
/* 상품 설명 페이지 쿼리스트링 값 추출 ===========================
*/
String product_code = request.getParameter("product_code");
String product_size = "";
int product_count = 1;

/* 상품 DTO 생성 후 조건문에서 반환받은 DTO 할당 ===========================
*/
ShopProductDTO product = new ShopProductDTO();
if (product_code == null || product_size == null) { // 정상적인 실행경로 아닐때
	response.sendRedirect(contextPath + "/CtrlPd.do?page=pageMain");
} else {
	product = (ShopProductDTO)buyMap.get("product");
	product_size = (String)buyMap.get("size");
	product_count = (Integer)buyMap.get("product_count");
}

int myPrice = product.getProduct_price() * product_count; // 가격 x 수량
int tax = 5500; // 세금
int deliveryPay = 3000; // 배송비
DecimalFormat noFormat = new DecimalFormat(); // NumberFormat 클래스의 상속. 추상메소드가 존재해 상속받은 클래스 사용
String formatMyPrice = noFormat.format(myPrice); // 가격 x 수량 포멧
int totalPrice = myPrice + tax + deliveryPay; // 가격 x 수량 + 세금 + 배송비
String formatTotalPrice = noFormat.format(totalPrice); // 총 금액 포멧

// 분리된 이미지 ==================================
String mainImg = (String)buyMap.get("product_img");
%>
<title><%=product.getProduct_name()%> 구매</title>
</head>
<body>
   <div id="__nuxt">
   <img src = "<%=prjPath%>/img/logo.png" id = "logo" onclick = "alert('구매 취소'), setTimeout(location.href = '<%=prjPath%>/CtrlPd.do?page=pageMain', 2000)">
   <form method="post" action = "<%=contextPath%>/CtrlPd.do">
   <%-- 구매 완료 페이지에 전달할 인자 --%>
   <input type = "hidden" name = "page" value = "proBuy">
   <input type = "hidden" name = "buy_id" value="<%=userDTO.getUser_id()%>">
   <input type = "hidden" name = "buy_productcode" value = "<%= product.getProduct_code() %>">
   <input type = "hidden" name = "buy_productname" value = "<%= product.getProduct_name()%>">
   <input type = "hidden" name = "buy_productimg" value = "<%= mainImg%>">
   <input type = "hidden" name = "buy_cnt" value="<%=product_count%>">
   <input type = "hidden" name = "buy_price" id = "buy_price" value="<%= totalPrice%>">
   <input type = "hidden" name = "buy_addr" value = "<%=userDTO.getUser_addr()%>">
   </form>
        <div id="__layout"><!-- 전체 설정-->
            <div class="wrapper" tabindex="0">
                <div>   
                </div><!---->
                <div class="container buy"><!-- 전체 배경색 -->
                    <div class="content"><!-- 내용이 들어갈 div-->
                        <div class="buy_immediate">
                            <div class="product_info_area">
                                <div class="product_info">
                                    <div class="product" >
                                        <!--구매하려는 상품 div 사진 위치-->
                                        <picture class="picture product_img">
                                            <img alt="상품 이미지" class="image full_width" src="<%=prjPath%>/img<%=mainImg%>">
                                        </picture><!----><!----><!---->
                                    </div>
                                    <div class="product_detail"><strong class="model_number"><!--DJ6188-001--><%= product.getProduct_code() %></strong>
                                        <p class="model_title"><%= product.getProduct_name() %></p>
                                        <p class="model_ko"><%= product.getProduct_brand() %></p>
                                        <div class="model_desc">
                                            <p class="size_txt"><%= product_size %></p><!---->
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="display_item thick_separator" style="background-color: rgb(244, 244, 244);">
                            </div>
                            <section class="privacy"><!--배송주소 div-->
                                <div class="section_unit">
                                    <div class="section_title">
                                        <h3 class="title_txt">배송 주소</h3><a href="#" class="add_more_btn">+ 새 주소 추가</a>
                                    </div>
                                    <div class="section_content">
                                        <div class="delivery_info">
                                            <div class="address_info">
                                                <dl class="info_list">
                                                    <div class="info_box">
                                                        <dt class="title">받는 분</dt>
                                                        <dd class="desc"><%= userDTO.getUser_name() %></dd>
                                                    </div>
                                                    <div class="info_box">
                                                        <dt class="title">연락처</dt>
                                                        <dd class="desc"><%= userDTO.getUser_phone() %></dd>
                                                    </div>
                                                    <div class="info_box">
                                                        <dt class="title">배송 주소</dt>
                                                        <dd class="desc"><%= userDTO.getUser_addr() %></dd>
                                                    </div>
                                                </dl>
                                            </div><a href="#" class="btn btn_edit outlinegrey small"> 변경 </a>
                                        </div>
                                        <div>
                                            <div class="button_shipping_memo_wrap">
                                                <button class="button_shipping_memo">
                                                    <span class="updated_memo">문 앞에 놓아주세요 </span>
                                                </button>
                                            </div><!---->
                                        </div>
                                    </div>
                                </div>
                                <div class="section_unit">
                                    <div class="section_title">
                                        <h3 class="title_txt">배송 방법</h3>
                                    </div>
                                    <div class="section_content"><!-- 배송방법-->
                                        <div class="delivery_service_option selected">
                                            <div class="delivery_way">
                                                <div class="way_info">
                                                    <div class="way-status-thumbnail"><img src="<%=prjPath%>/img/icon/box1.png"
                                                            alt="3,000원" class="way_img"></div>
                                                    <div class="way_desc">
                                                        <p class="company"><span class="badge_title">일반배송 </span><span
                                                                class="title">3,000원</span><!----></p>
                                                        <p class="sub_text">검수 후 배송 ・ 9-11일 내 도착 예정
                                                        </p>
                                                    </div>
                                                </div><!---->
                                            </div>
                                        </div>
                                        <div class="delivery_service_option">
                                            <div class="delivery_way">
                                                <div class="way_info">
                                                    <div class="way-status-thumbnail"><img src="<%=prjPath%>/img/icon/chango.png"
                                                            alt="첫 30일 무료" class="way_img"></div>
                                                    <div class="way_desc">
                                                        <p class="company"><span class="badge_title">창고보관 </span>
                                                            <span class="title">첫 30일 무료</span>
                                                            <span role="button" aria-label="배송안내"></span>
                                                        </p>
                                                        <p class="sub_text">배송 없이 창고에 보관 ・ 빠르게 판매 가능
                                                        </p>
                                                    </div>
                                                </div><!---->
                                            </div>
                                        </div>
                                    </div>
                                </div><!----><!---->
                            </section>
                            <div class="display_item thick_separator" style="background-color: rgb(244, 244, 244);"> <!--간격-->
                            </div>
                            <div class="review_section">
                                <section class="section_content display_item order_discount">
                                    <div class="section_title">
                                        <h3 class="title_txt">할인 혜택</h3>
                                    </div>
                                    <h4 class="method_title">
                                        <div class="main_title">
                                            <p class="">쿠폰</p><span class="sub_title" style="display: none;"></span>
                                        </div>
                                    </h4>
                                    <div class="section_input"><button disabled="disabled"
                                            class="input_coupon disabled"><span class="coupon_name disabled">사용 가능한
                                                쿠폰이
                                                없습니다.</span><svg xmlns="http://www.w3.org/2000/svg"
                                                class="ico-arr-right-gray coupon_arrow icon sprite-icons">
                                                <use href="/_nuxt/902a7eb5512d7d4f25543902cfd1ccdc.svg#i-ico-arr-right-gray"
                                                    xlink:href="/_nuxt/902a7eb5512d7d4f25543902cfd1ccdc.svg#i-ico-arr-right-gray">
                                                </use>
                                            </svg></button><button class="btn_use_coupon disabled"> 최대 사용 </button>
                                    </div>
                                    <h4 class="method_title">
                                        <div class="main_title">
                                            <p class="">포인트</p><span class="sub_title" style="display: none;"></span>
                                        </div>
                                    </h4>
                                    <div>
                                        <div class="section_input"><input placeholder="0" disabled="disabled"
                                                class="input_credit disabled"><button class="btn_use_credit disabled">
                                                최대 사용 </button></div>
                                        <div class="info_point">
                                            <div><span class="text_current">보유 포인트</span>
                                                <div class="value_current"><span class="point">0</span><span
                                                        class="unit">P</span></div>
                                            </div><!---->
                                        </div>
                                    </div>
                                    <div class="v-portal" style="display: none;"></div>
                                </section><!---->
                                    <div class="section_content separator"> <!--간격 유지-->
                                        <div class="display_item thick_separator"
                                            style="background-color: rgb(244, 244, 244);"></div>
                                    </div>
                                <section><!-- 결제 방법-->
                                    <div class="section_content display_item">
                                        <div class="section_title">
                                            <h3 class="title_txt">결제 방법</h3>
                                        </div>
                                        <div>                                            
                                            <div class="payment_section">
                                                <h4 class="method_title">
                                                    <div class="main_title">
                                                        <p class="">일반 결제</p><span class="sub_title"
                                                            style="display: none;"></span><span class="sub_title"
                                                            style="color: rgba(34, 34, 34, 0.5);"> 일시불·할부 </span>
                                                    </div>
                                                </h4><!---->
                                                <div class="pay_method md">
                                                    <div class="pay_item normal">
                                                        <div class="pay_box">
                                                            <div class="pay_title">
                                                                <p class="cardmain_title">신용카드</p><!---->
                                                            </div><!---->
                                                        </div>
                                                    </div>
                                                    <div class="pay_item naverpay">
                                                        <div class="pay_box">
                                                            <div class="pay_title">
                                                                <p class="cardmain_title">네이버페이</p>
                                                                <!---->
                                                            </div><img src="<%=prjPath%>/img/payment/npay.png" alt="네이버페이" class="pay_img">
                                                        </div>
                                                    </div>
                                                    <div class="pay_item kakaopay">
                                                        <div class="pay_box">
                                                            <div class="pay_title">
                                                                <p class="cardmain_title">카카오페이</p>
                                                                <!---->
                                                            </div><img src="<%=prjPath%>/img/payment/kakaopay.png" alt="카카오페이"
                                                                class="pay_img">
                                                        </div>
                                                    </div>
                                                    <div class="pay_item tosspay">
                                                        <div class="pay_box">
                                                            <div class="pay_title">
                                                                <p class="cardmain_title">토스페이</p><!---->
                                                            </div><img src="<%=prjPath%>/img/payment/toss.png" alt="토스페이" class="pay_img">
                                                        </div>
                                                    </div>
                                                    <div class="pay_item payco">
                                                        <div class="pay_box">
                                                            <div class="pay_title">
                                                                <p class="cardmain_title">페이코</p><!---->
                                                            </div><img src="<%=prjPath%>/img/payment/payco.png" alt="페이코" class="pay_img">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="payment_footer">
                                                    <p>체결 후 결제 정보 변경은 불가하며 분할 납부 변경은 카드사 문의 바랍니다. 단,
                                                        카드사별 정책에 따라 분할 납부 변경 시 수수료가 발생할 수 있습니다.</p>
                                                </div>
                                            </div>                                            
                                        </div>
                                        <div class="v-portal" style="display: none;"></div>
                                    </div>
                                </section>
                                    <div class="section_content separator">
                                        <div class="display_item thick_separator"
                                            style="background-color: rgb(244, 244, 244);"></div>
                                    </div>
                                <section>
                                    <div class="section_content">
                                        <div class="display_item plain_short_bottom_margin price_breakdown"
                                            style="background-color: rgb(255, 255, 255);">
                                            <div class="title_wrap">
                                                <div>
                                                    <p class="title">최종 주문정보</p><!---->
                                                </div><!---->
                                            </div>
                                            <div class="display_line line title_description">
                                                <p class="text-lookup line_title display_paragraph"
                                                    style="color: rgb(34, 34, 34);">즉시 구매가</p>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);"><em d
                                                            class="text-lookup bold"><%= formatMyPrice %>원</em></p><!----><!---->
                                                </div>
                                            </div>
                                            <div class="display_line line title_description">
                                                <p class="text-lookup line_title display_paragraph"
                                                    style="color: rgba(34, 34, 34, 0.5);">검수비</p>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);">무료</p><!----><!---->
                                                </div>
                                            </div>
                                            <div class="display_line line title_description">
                                                <div class="title_button_wrap">
                                                    <p class="text-lookup line_title display_paragraph"
                                                        style="color: rgba(34, 34, 34, 0.5);">수수료</p>
                                                </div>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);">5,500원</p><!----><!---->
                                                </div>
                                            </div>
                                            <div class="display_line line title_description">
                                                <p class="text-lookup line_title display_paragraph"
                                                    style="color: rgba(34, 34, 34, 0.5);">배송비</p>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);">3,000원</p><!----><!---->
                                                </div>
                                            </div>
                                            <div class="display_line line title_description">
                                                <p class="text-lookup line_title display_paragraph"
                                                    style="color: rgba(34, 34, 34, 0.5);">쿠폰 사용</p>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);">-</p><!----><!---->
                                                </div>
                                            </div>
                                            <div class="display_line line title_description">
                                                <p class="text-lookup line_title display_paragraph"
                                                    style="color: rgba(34, 34, 34, 0.5);">포인트 사용</p>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);">-</p><!----><!---->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <div class="section_content separator">
                                    <div class="display_item separator"
                                        style="background-color: rgb(240, 240, 240);"></div>
                                </div>
                                <section id="finalcash">
                                    <div class="section_content">
                                        <div class="display_item empty_header final_price"
                                            style="background-color: rgb(250, 250, 250);">
                                            <div class="title_wrap" style="display: none;">
                                                <div>
                                                    <p class="title" style="display: none;"></p>
                                                    <!---->
                                                </div><!---->
                                            </div>
                                            <div class="display_line line heavy_text">
                                                <p class="text-lookup line_title display_paragraph"
                                                    style="color: rgb(34, 34, 34);">총 결제금액</p>
                                                <div class="description_wrap">
                                                    <p class="text-lookup line_description display_paragraph"
                                                        style="color: rgb(34, 34, 34);"><em d
                                                            class="text-lookup bold"><%= formatTotalPrice %>원</em></p><!----><!---->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <div class="section_content separator">
                                    <div class="display_item separator"
                                        style="background-color: rgb(240, 240, 240);"></div>
                                </div>
                                <div class="section_content separator">
                                    <div class="display_item thick_separator"
                                        style="background-color: rgb(244, 244, 244);"></div>
                                </div>                                
                            </div>
                            <div class="order-agreements-button"><button 
                                    class="display_button large gray_filled disabled block bold"
                                    style="background-color:red; color: rgba(255, 255, 255, 0.8);">
                                    <div id = "shopBuyBtn" onclick="buy()"><%= formatTotalPrice %>원 <span style="color:#FFFFFFA6;" class="">•</span> 일반배송 결제하기
                                    </div><!---->
                                </button>
                                <div class="v-portal" style="display: none;"></div>
                            </div><!----><!----><!----><!----><!---->
                        </div><!----><!---->
                    </div><!----><!---->
                </div>
            </div>
        </div>
    </div>
    <script>
    var hi;
    var price;
    var addr;
    var code;
    function buy(){
    	//code=document.getElementsByClassName("model_number");
    	price=document.getElementsByClassName("text-lookup line_description display_paragraph");
    	addr=document.getElementsByClassName("desc");
    
 
    	hi =document.getElementsByTagName("input");
    	//hi[1].value=code[0].innerText;
    	//hi[3].value=price[0].innerText;
    	//hi[4].value=addr[2].innerText;
    	//alert(hi[1].value);
    	//alert(hi[3].value);
    	//alert(hi[4].value);
    	
    	//document.getElementsByTagName("form")[0].action = "";
		document.getElementsByTagName("form")[0].submit();
    }
    </script>
</body>
</html>