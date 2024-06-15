<%@ page import="shop.ShopGUI"%>
<%@ page import="java.util.List"%>
<%@ page import="shop.ShopNotificationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">   
    <title>공지사항</title>
    <%
    //경로 설정
    	String contextPath = request.getContextPath();
		String cssConPath = contextPath + "/shopFrame/css/shop_headerContainer.css";
		String cssMainPath = contextPath + "/shopFrame/css/shop_notification.css";
		String cssPagination = contextPath + "/shopFrame/css/pagination.css";
		
		ShopGUI gui = new ShopGUI();
	%>
    <link rel = "stylesheet" href = "<%=cssConPath%>">
    <link rel = "stylesheet" href = "<%=cssMainPath%>">
    <link rel = "stylesheet" href = "<%=cssPagination%>">     
    <%
	request.setCharacterEncoding("utf-8");
    List<ShopNotificationDTO> dtoL = (List<ShopNotificationDTO>)request.getAttribute("dtoL");	
	%>
</head>
<body>
<%
			if(dtoL != null ){
				int totalRecord = dtoL.size();
				int recPerPage = 10;
				int pagePerBlock = 10;

				int totalPage = (int)Math.ceil((double)totalRecord / recPerPage);
				int totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);

				int nowPage = 0;
				int nowBlock = 0;

				if(request.getParameter("nowPage") != null)
					nowPage = Integer.parseInt(request.getParameter("nowPage"));
				if(request.getParameter("nowBlock") != null)
					nowBlock = Integer.parseInt(request.getParameter("nowBlock"));

				int recOfBeginPage = nowPage * recPerPage;
				int pageOfBeginBlock = nowBlock * pagePerBlock;		
				
				String ch="";
				Cookie[] cokChk = request.getCookies();
				Cookie cok = new Cookie("guiCheckbox","true");
				
				
				gui.guiRun(dtoL.get(0).getNotification_Subject(), dtoL.get(0).getNotification_Content());
			%>
	<div id = "container">
	    <%@ include file = "./shop_header.jsp" %>
    </div>
    <div id="wrapper">
        <h1>공지사항</h1>
        <div class="blackstick"></div>
        <ul>
                    <%
            for(int idx = recOfBeginPage; idx < recOfBeginPage + recPerPage; idx++){
            	// 현재 페이지의 레코드부터 현재레코드 + 10까지
        		if(idx >= totalRecord) break; // idx가 totalRecord보다 크거나 같으면 반복 중지
            %>
        
            <li><div class="licc"><a href="<%=contextPath %>/shopFrame/jsp/shop_notification_content.jsp?notification_No=<%=dtoL.get(idx).getNotification_No()%>"><%=dtoL.get(idx).getNotification_Subject() %></a></div><hr></li>            
        	<%
            }%>
            <div class="buttons">				
				<a class="buts" href="<%=contextPath %>/shopFrame/jsp/shop_notification_write.jsp">공지사항 작성하기</a>
			</div>
			<% if(totalBlock > 0) { // 블록의 페이지 수가 0보다 큰 경우에만 출력 %>
            <%
            if(nowBlock != 0){ // nowBlock이 0이면 뒤로가기 출력 X
            %>
            	<a class = "select" href = "./CtrlNotification.do?page=pageNotification&nowPage=<%=(nowBlock-1)*pagePerBlock%>&nowBlock=<%=nowBlock-1%>">≪</a>
            <%
            }
            %>
        	<%
        	for(int idx1 = pageOfBeginBlock; idx1 < pageOfBeginBlock + pagePerBlock; idx1++){
        		// 현재 블럭의 페이지부터 페이지 + 10까지 페이지 선택 출력
        	%>
        		<a class = "select" href = "./CtrlNotification.do?page=pageNotification&&nowPage=<%=idx1%>&nowBlock=<%=nowBlock%>"><%=idx1+1%></a>
        	<%
        		if(idx1 + 1 == totalPage) break; // 총 페이지까지 페이지 선택 버튼 출력
        	}
        		if(nowBlock + 1 < totalBlock){ // 총 블럭의 수 전의 블럭에 있으면 앞으로가기 출력
        	%>
        	<a class = "select" href = "./CtrlNotification.do?page=pageNotification&nowPage=<%=(nowBlock+1)*pagePerBlock%>&nowBlock=<%=nowBlock+1%>">≫</a>
        	<%
        		}
        		}
	        	else{
	        	}
        	}
        	%>
        </ul>
    </div>
</body>
</html>