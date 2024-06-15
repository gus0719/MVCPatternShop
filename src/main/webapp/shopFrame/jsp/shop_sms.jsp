<%@page import="shop.ShopUserDAO"%>
<%@page import="shop.ShopUserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:useBean id="shopUserDAO" class = "shop.ShopUserDAO"/>
<jsp:useBean id="shopsms" class = "shop.ShopSMSSend"/>
<%
	request.setCharacterEncoding("utf-8");

	String contextPath = request.getContextPath();
	//control
	String realPath = contextPath + "/CtrlMember.do";


	String phone = request.getParameter("user_phone");
	String id = request.getParameter("user_id");
	String cate = request.getParameter("user_cate");
	ShopUserDTO dto = new ShopUserDTO();
	ShopUserDAO dao  = new ShopUserDAO();
	String smsMsg="";
	String msg="";
	ShopUserDTO phoneDB = dao.shopFind(phone);
	//비밀번호 찾기일때
	if(cate.equals("password")){
	if(phone.equals(phoneDB.getUser_phone())&&id.equals(phoneDB.getUser_id())){
		 // smsMsg = shopsms.smsSend(phone);
		  smsMsg ="123456";
		msg = ("입력하신 전화번호로 인증번호를 전송하였습니다.");
	}else {
		msg = "false";	
		}
	}
	//아이디 찾기일때
	if(cate.equals("id")){
		if(phone.equals(phoneDB.getUser_phone())){
			//smsMsg = shopsms.smsSend(phone);
			smsMsg ="123456";
			msg = ("입력하신 전화번호로 인증번호를 전송하였습니다.");
		}else {
			msg = "false";	
			}
		}
	//회원가입 휴대폰 인증일때
	if(cate.equals("phone")){
		if(phone.length()==11){
			//smsMsg = shopsms.smsSend(phone);
			smsMsg ="123456";
			msg = ("입력하신 전화번호로 인증번호를 전송하였습니다.");
		}else {
			msg = "phonefalse";	
			}
		}
	
	%>

<link rel = "stylesheet" href = "<%=contextPath%>/shopFrame/css/shop_sms.css">
</head>
<body id="wrapper" onload="mInit()">

	
	<form action="<%=realPath %>" method="post">
		<table>

			<tr class="tr1">
				<td><b>** 인증번호를 입력하세요 **</b></td>
			</tr>

			<tr class="tr2">

				<td><input type="hidden"  name="shop_id" id="shop_id" value="<%=id%>" >
				<input type="hidden"  name="shop_phone" id="shop_phone" value="<%=phone%>" >
				<input type="hidden"   id="sms" value="<%=smsMsg%>" >
				<input type="hidden"  name ="cate" id="cate" value="<%=cate%>" >
				<input type="hidden"   id="msg" value="<%=msg%>" >
				<input type="hidden" value="" name="page" id="page">
				<input class="textfiled" id = pwd type="text" ></td>
			</tr>

			<tr class="tr3">
				<td><input class="button" type="button" value="확인" onclick="send(pwd.value)"></td>	 
			</tr>

		</table>
	</form>
	<script>
		function mInit() {
			objPwd = document.getElementsByTagName("input");
			if(document.getElementById("msg").value=="false"){
				alert("존재하지 않는 회원입니다.");
				//location.href = "./shop_login.jsp";
				document.getElementById("page").value = 'pageLog';
				document.forms[0].submit();
			}else if(document.getElementById("msg").value=="phonefalse"){
				alert("휴대폰 번호 입력이 잘못되었습니다.");
				//location.href = "./shop_login.jsp";
				document.getElementById("page").value = 'pageLog';
				document.forms[0].submit();
			}else{
				alert("입력하신 전화번호로 인증번호가 발송되었습니다.");
			}	
			objPwd[3].focus();
		}
		function send(smsChk) {
			let sms = document.getElementById("sms");
			if(document.getElementById("cate").value=="password"){
				if(smsChk==sms.value){
					alert("인증번호 일치 확인. 해당 메뉴로 이동합니다.")
					//document.forms[0].action = "shop_passwordfindPro.jsp";
					document.getElementById("page").value = 'proPwdfind';
					alert(document.getElementById("page").value);
					document.forms[0].submit();
				}else{
					alert("인증번호가 일치하지 않습니다.");
					vPwd.select();
				} 
			}
			if(document.getElementById("cate").value=="id"){
				if(smsChk==sms.value){
					alert("인증번호 일치 확인. 해당 메뉴로 이동합니다.")
					//document.forms[0].action = "shop_idfindPro.jsp";
					document.getElementById("page").value = 'proIdfind';
					alert(document.getElementById("page").value);
					document.forms[0].submit();
				}else{
					alert("인증번호가 일치하지 않습니다.");
					vPwd.select();
				} 
			}		
			if(document.getElementById("cate").value=="phone"){
				if(smsChk==sms.value){
					alert("인증번호 일치 확인. 해당 메뉴로 이동합니다.")
					//document.forms[0].action = "shop_member.jsp";
					document.getElementById("page").value = 'pageMember';
					document.forms[0].submit();
				}else{
					alert("인증번호가 일치하지 않습니다.");
					vPwd.select();
				}
			}
		}
	</script>
</body>
</html>