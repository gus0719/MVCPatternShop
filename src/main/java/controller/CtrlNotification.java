package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import shop.ShopNotificationDAO;
import shop.ShopNotificationDTO;

@WebServlet("/CtrlNotification.do")
public class CtrlNotification extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String user_id;
	private HttpSession session;
	
	RequestDispatcher rd;

	public CtrlNotification() {
	}

	public void init(ServletConfig config) throws ServletException {
	}

	public void destroy() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 글자 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		// 객체 생성 및 가져오기
		String contextPath = request.getContextPath();
		String realPath = contextPath + "/shopFrame/jsp/";
		String page = request.getParameter("page");
		String msg = request.getParameter("msg");
		String notificationSubject = request.getParameter("notification_Subject");
		String notificationContent = request.getParameter("notification_Content");
		String notification_No = request.getParameter("notification_No");
		String id;

		session = request.getSession();
		user_id = (String)session.getAttribute("user_id");

		// Page ====================================

		

		// DTO , DAO
		ShopNotificationDTO dto = new ShopNotificationDTO();
		ShopNotificationDAO dao = new ShopNotificationDAO();

		// RequestDispatcher
		
		// 게시판 페이지 이동
		if (page.equals("pageNotification")) {
			realPath = "/shopFrame/jsp/shop_notification.jsp";
			List<ShopNotificationDTO> dtoL = dao.bodSelect();
			request.setAttribute("dtoL", dtoL);
			rd = request.getRequestDispatcher(realPath);
			rd.forward(request, response);			
			return;
		} 
		
		
		
		if (user_id == null) {
			msg = "로그인이 필요한 서비스입니다.";
			response.sendRedirect(realPath + "shop_login.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
			return;
		}
		if (page.equals("write")) {			
			dto.setNotification_Id(user_id);			
			dto.setNotification_Subject(notificationSubject);
			dto.setNotification_Content(notificationContent);
			int su = dao.notiWrite(dto);
			if (su != 0) {
				msg = URLEncoder.encode(user_id + "님 게시판 등록 성공", "UTF-8");
			} else {
				msg = URLEncoder.encode(user_id + "님 게시판 등록 실패", "UTF-8");
			}
			realPath = "/shopFrame/jsp/shop_notification.jsp";
			List<ShopNotificationDTO> dtoL = dao.bodSelect();
			request.setAttribute("dtoL", dtoL);
			rd = request.getRequestDispatcher(realPath);
			rd.forward(request, response);			
			return;
		} 
		
		if (page.equals("updateChk")) {
			// 수정 로직 추가
			dto = dao.bodSelect(Integer.parseInt(notification_No));
			dto.setNotification_Id(user_id);
			id = dto.getNotification_Id();			
			if (id.equals(user_id)) {				
				realPath = "/shopFrame/jsp/shop_notification_update.jsp?notification_No=" + notification_No;				
				request.setAttribute("dto", dto);
				rd = request.getRequestDispatcher(realPath);
				rd.forward(request, response);
				return;
				//response.sendRedirect(realPath + "shop_notification_update.jsp?notification_No=" + notification_No);
			} else {
				response.sendRedirect(realPath + "shop_notification_content.jsp?notification_No=" + notification_No);
			}
			//response.sendRedirect(realPath + "shop_notification_update.jsp?notification_No=" + notification_No);
		} else if (page.equals("update")) {
			// 수정 로직 추가/
			dto.setNotification_Id(user_id);
			dto.setNotification_No(Integer.parseInt(notification_No));
			dto.setNotification_Subject(notificationSubject);
			dto.setNotification_Content(notificationContent);
			int result = dao.bodUpdate(dto);
			realPath = "/shopFrame/jsp/shop_notification.jsp";
			List<ShopNotificationDTO> dtoL = dao.bodSelect();
			request.setAttribute("dtoL", dtoL);
			rd = request.getRequestDispatcher(realPath);
			rd.forward(request, response);			
			return;	
		} else if (page.equals("delete")) {
			dto.setNotification_Id(user_id);
			dto = dao.bodSelect(Integer.parseInt(notification_No));
			id = dto.getNotification_Id();	
			if(id.equals(user_id)) {
				int su = dao.bodDelete(dto);
				if (su != 0) {
					msg = URLEncoder.encode("게시글 삭제 성공", "UTF-8");
				} else {
					msg = URLEncoder.encode("게시글 삭제 실패", "UTF-8");
				}
				realPath = "/shopFrame/jsp/shop_notification.jsp";
				List<ShopNotificationDTO> dtoL = dao.bodSelect();
				request.setAttribute("dtoL", dtoL);
				rd = request.getRequestDispatcher(realPath);
				rd.forward(request, response);			
				return;
			} else {
				response.sendRedirect(realPath + "shop_notification_content.jsp?notification_No=" + notification_No);
			}
		}
	}
}