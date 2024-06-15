package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CtrlHeader
 */
@WebServlet("/CtrlHeader.do")
public class CtrlHeader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String page;
	private String search;
	private RequestDispatcher rd;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlHeader() {
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}
	
	private void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		page = request.getParameter("page");
		search = request.getParameter("search");
		
		String prjPath = request.getContextPath();
		
		// CtrlPd.do -> 메인, 장바구니, 상품등록
		if(page.equals("pageMain") || page.equals("pageCart")
			|| page.equals("pageRaiseProduct")) {
			prjPath += "/CtrlPd.do?page="+page;
		}
		
		// CtrlNotification.do
		if(page.equals("pageNotification")) {
			prjPath += "/CtrlNotification.do?page="+page;
		}
		
		// CtrlPd.do -> 검색
		if(page.equals("pageSearch")) {
			prjPath += "/CtrlPd.do?page="+page+"&search="+URLEncoder.encode(search, "UTF-8");
		}
		
		// CtrlMember.do -> 로그인, 로그아웃, 회원가입, 마이페이지
		if(page.equals("pageLog") || page.equals("pageLogout")
			|| page.equals("pageMember") || page.equals("pageMy")) {
			prjPath += "/CtrlMember.do?page="+page;
		}

		// 조건문 페이지 이동
		response.sendRedirect(prjPath);
	}
}