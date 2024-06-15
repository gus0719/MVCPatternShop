package controller;

// 상품 =====================
import shop.ShopProductDAO;
import shop.ShopProductDTO;

// 관심상 =====================
import shop.ShopInterestDAO;
import shop.ShopInterestDTO;

// 장바구니 =====================
import shop.ShopCartDAO;
import shop.ShopCartDTO;

// 구매 =====================
import shop.ShopBuyDAO;
import shop.ShopBuyDTO;

// 위키
import shop.ShopWikiDAO;
import shop.ShopWikiDTO;

// 유저
import shop.ShopUserDAO;
import shop.ShopUserDTO;

// Java SE 8 ================
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.ArrayList;
import java.net.URLEncoder;


// javax.servlet =============================
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CtrlPd
 */
@WebServlet("/CtrlPd.do")
public class CtrlPd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String page; // 쿼리스트링 페이지 구분
	
	private String msg; // 결과 메시지
	
	private int product_code; // 상품코드
	private String product_category; // 카테고리
	private String product_brand; // 브랜드
	private String product_name; // 상품명
	private int product_price; // 상품가격
	private String product_explain; // 상품설명
	private String product_seller; // 판매자
	private String product_img; // 상품이미지
	
	// 구매페이지 상품 옵션
	private String product_size;
	private int product_count;
	
	private String query_category; // 쿼리스트링 카테고리
	private String query_brand; // 쿼리스트링 브랜드
	
	private String query_search; // 쿼리스트링 검색 파라미터 
	
	// 위키 텍스트
	private String wiki_text;
	
	
	// 이미지 분할용 변수
	private String imgArrText;
	private String[] imgArr;
	
	// 로그인 세션
	private String user_id;
	
	
	// RequestDispatcher
	private RequestDispatcher rd;
	
	// Session
	private HttpSession session;
	

    public CtrlPd() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	
	// GET POST 동시 처리
	private void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter(); // AJAX 결과 전달용
		
		// 세션 호출
		session = request.getSession();
		
		// 프로젝트 경로
		String contextPath = request.getContextPath();
		String prjJSPPath = "/shopFrame/jsp";
		
		// 상품 DTO =======================
		//
		product_code = (request.getParameter("product_code") != null)
				? Integer.parseInt(request.getParameter("product_code")) : 0;
		product_category = request.getParameter("product_category");
		product_brand = request.getParameter("product_brand");
		product_name = request.getParameter("product_name");
		product_price = (request.getParameter("product_price") != null)
				? Integer.parseInt(request.getParameter("product_price")) : 0;
		product_explain = request.getParameter("product_explain");
		product_seller = request.getParameter("product_seller");
		product_img = request.getParameter("product_img");
		
		// 구매 페이지 상품 옵션
		product_size = request.getParameter("size");
		product_count = (request.getParameter("product_count") != null)
				? Integer.parseInt(request.getParameter("product_count")) : 1;
		
		
		// 카레고리 쿼리스트링 =========================
		//
		query_category = request.getParameter("category");
		query_brand = request.getParameter("brand");
		
		// 검색 쿼리스트링
		query_search = request.getParameter("search");
		
		// 페이지
		page = request.getParameter("page");
		
		// 로그인 세션 얻기
		user_id = (String)session.getAttribute("user_id");
		
		// 상품 관련 DAO 객체 생성
		ShopProductDAO productDAO = new ShopProductDAO();
		ShopInterestDAO interestDAO = new ShopInterestDAO();
		ShopCartDAO cartDAO = new ShopCartDAO();
		ShopBuyDAO buyDAO = new ShopBuyDAO();
		ShopWikiDAO wikiDAO = new ShopWikiDAO();
		
		// 유저 정보 DAO 객체 생성
		ShopUserDAO userDAO = new ShopUserDAO();
		
		if(page != null) {
			// 메인 페이지(shop_main.jsp) =============
			if(page.equals("pageMain")) {
				prjJSPPath += "/shop_main.jsp";
				HashMap<String, ArrayList<ShopProductDTO>> mainMap = new HashMap<String, ArrayList<ShopProductDTO>>();
				// 랜덤 상품
				ArrayList<ShopProductDTO> randomList = new ArrayList<ShopProductDTO>();
				try {
					int[] randomProductCode = productDAO.randomProduct();
					for(int idx = 0; idx < randomProductCode.length; idx++) {
						ShopProductDTO randomDTO = productDAO.getProduct(randomProductCode[idx]);
						randomList.add(randomDTO); // 상품 할당
					}
				} catch(IndexOutOfBoundsException e) {
					e.printStackTrace();
				}
				mainMap.put("randomList", randomList);
				
				// 구매율 TOP 5 상품
				ArrayList<Integer> top5Code = productDAO.getTop5();
				ArrayList<ShopProductDTO> top5Products = new ArrayList<ShopProductDTO>();
				for(int idx = 0; idx < top5Code.size(); idx++) {
					top5Products.add(productDAO.getProduct(top5Code.get(idx)));
				}
				mainMap.put("top5Products", top5Products);
				
				// 관심상품
				ArrayList<ShopInterestDTO> interestItems = interestDAO.interestList(user_id);
				ArrayList<ShopProductDTO> interests = new ArrayList<ShopProductDTO>();
				for(int idx = 0; idx < interestItems.size(); idx++) {
					interests.add(productDAO.getProduct(interestItems.get(idx).getInterest_productcode()));
				}
				mainMap.put("interests", interests);
				
				// 10만원 이하 상품
				ArrayList<ShopProductDTO> lessThanPrice = productDAO.lessThanPrice(100000);
				mainMap.put("lessThanPrice", lessThanPrice);
				
				request.setAttribute("mainMap", mainMap);
				
				// 제어권 부여
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			// 카테고리 페이지(shop_category.jsp) // =========================
			if(page.equals("pageCategory")) {
				prjJSPPath += "/shop_category.jsp";
				
				// 카테고리 상품, 브랜드 상품 조건 비교 후 적용
				HashMap<String, Object> categoryMap = new HashMap<String, Object>();
				ArrayList<ShopProductDTO> items = productDAO.categorySel(query_category);
				if(query_brand != null) {
					items = productDAO.categoryToBrandSel(query_category, query_brand);
				}
				categoryMap.put("items", items);
				
				// 브랜드 목록 출력
				ArrayList<String> brands = productDAO.shop_categories(query_category);
				categoryMap.put("brands", brands);
				
				request.setAttribute("categoryMap", categoryMap);
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 상품 설명 페이지(shop_explain.jsp) ===============
			if(page.equals("pageExplain")) {
				prjJSPPath += "/shop_explain.jsp";
				HashMap<String, Object> explainMap = new HashMap<String, Object>();
				if(product_code == 0) {
					response.sendRedirect(prjJSPPath + "/shop_main.jsp?page=pageMain");
				}
				ShopProductDTO explainDTO = productDAO.getProduct(product_code);
				String wiki_text = wikiDAO.getWikiOfCode(product_code);
				int interestState = interestDAO.interestState(user_id, product_code);
				explainMap.put("explainDTO", explainDTO);
				explainMap.put("wiki_text", wiki_text);
				explainMap.put("interestState", interestState);
				
				request.setAttribute("explainMap", explainMap);
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 상품 구매 페이지(shop_cart.jsp)
			if(page.equals("pageBuy")) {
				// 유저 정보
				prjJSPPath += "/shop_buy.jsp";
				HashMap<String, Object> buyMap = new HashMap<String, Object>();
				ShopUserDTO userDTO = userDAO.myPageChk(user_id);
				ShopProductDTO product = productDAO.getProduct(product_code);
				if(product_code == 0) {
					response.sendRedirect(prjJSPPath + "/shop_main.jsp?page=pageMain");
				}
				buyMap.put("userDTO", userDTO);
				buyMap.put("product", product);
				buyMap.put("size", product_size);
				buyMap.put("product_count", product_count);
				buyMap.put("product_img", product_img);
				
				request.setAttribute("buyMap", buyMap);
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 장바구니 페이지
			if(page.equals("pageCart")) {
				prjJSPPath += "/shop_cart.jsp";
				HashMap<String, Object> cartMap = new HashMap<String, Object>();
				ArrayList<ShopCartDTO> items = cartDAO.getFromCart(user_id);
				ArrayList<ShopProductDTO> cartList = new ArrayList<ShopProductDTO>();
				for(int idx = 0; idx < items.size(); idx++) {
					int cartNo = items.get(idx).getCart_code();
					ShopProductDTO cartItem = productDAO.getProduct(cartNo);
					cartList.add(cartItem);
				}
				cartMap.put("items", items);
				cartMap.put("cartList", cartList);
				
				request.setAttribute("cartMap", cartMap);
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 구매 리스트 페이지
			if(page.equals("pageBuyList")) {
				prjJSPPath += "/shop_buyList.jsp";
				ArrayList<ShopBuyDTO> buyList = buyDAO.buyList(user_id);
				request.setAttribute("buyList", buyList);
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 상품 검색
			if(page.equals("pageSearch")) {
				//out.print("<h1>"+query_search+"</h1>");
				prjJSPPath += "/shop_search.jsp";
				ArrayList<ShopProductDTO> searchList = productDAO.searchProductName(query_search);
				request.setAttribute("searchList", searchList);
				
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 상품 등록
			if(page.equals("pageRaiseProduct")) {
				prjJSPPath += "/shop_raiseProduct.jsp";
				ShopUserDTO userDTO = userDAO.myPageChk(user_id);
				request.setAttribute("userDTO", userDTO);
				
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			/* ==============================================
			 * 				  요청 처리 페이지				   *
			===============================================*/
			// 구매 처리 후 주문 내역 페이지
			if(page.equals("proBuy")) {
				prjJSPPath = "/shopFrame/jsp/shop_order.jsp";
				user_id = request.getParameter("buy_id");
				product_code = Integer.parseInt(request.getParameter("buy_productcode"));
				product_name = request.getParameter("buy_productname");
				product_img = request.getParameter("buy_productimg");
				product_count = Integer.parseInt(request.getParameter("buy_cnt"));
				product_price = Integer.parseInt(request.getParameter("buy_price"));
				String buy_addr = request.getParameter("buy_addr");
				ShopBuyDTO buyDTO = new ShopBuyDTO(user_id, product_code, product_name,
						product_img, product_count, product_price, buy_addr);
				int su = buyDAO.shopBuy(buyDTO);
				if(su != 0) {
					msg = user_id + "님 구매 성공";
				} else {
					msg = user_id + "님 구매 실패";
				}
				HashMap<String, Object> orderMap = new HashMap<String, Object>();
				orderMap.put("msg", msg);
				orderMap.put("buyDTO", buyDTO);
				
				ShopUserDTO userDTO = userDAO.myPageChk(buyDTO.getBuy_id());
				orderMap.put("userDTO", userDTO);
				
				request.setAttribute("orderMap", orderMap);
				rd = request.getRequestDispatcher(prjJSPPath);
				rd.forward(request, response);
			}
			
			// 장바구니 담기
			if(page.equals("proCart")) {
				if(user_id == null) {
					msg = "로그인이 필요한 서비스입니다.";
					response.sendRedirect(contextPath + "/CtrlMember.do?page=pageLog&msg="+URLEncoder.encode(msg, "UTF-8"));
					return;
				}
				prjJSPPath = contextPath + "/CtrlPd.do?page=pageCart";
				ShopCartDTO cartItem = new ShopCartDTO(user_id, product_code, product_name, product_img, product_count);
				int su = cartDAO.putInCart(cartItem);
//				if(su != 0)	msg = "장바구니 등록 성공";
//				else msg = "장바구니 등록 실패";
				
				//response.sendRedirect(prjJSPPath+"&msg="+URLEncoder.encode(msg, "UTF-8"));
				response.sendRedirect(prjJSPPath);
			}
			
			// 장바구니 삭제
			if(page.equals("proCartDel")) {
				int su = cartDAO.delItem(user_id, product_code);
				if(su != 0) {
					out.print("장바구니 삭제 성공");
				} else {
					out.print("장바구니 삭제 실패");
				}
			}
			
			// 관심상품 추가
			if(page.equals("proInterest")) {
				if(user_id == null) {
					out.print("로그인이 필요한 서비스입니다");
				}
				ShopInterestDTO interestDTO = new ShopInterestDTO(user_id, product_code, product_name, product_img);
				int su = interestDAO.appendInterest(interestDTO);
				if(su != 0) {
					out.print("관심상품 등록 성공");
				} else {
					out.print("관심상품 등록 실패");
				}
			}
			
			// 관심상품 삭제
			if(page.equals("proInterest_del")) {
				int su = interestDAO.delInterest(user_id, product_code);
				if(su != 0) {
					out.print("관심상품 삭제 성공");
				} else {
					out.print("관심상품 삭제 실패");
				}
			}
			
			// 위키 등록 or 갱신
			if(page.equals("proWiki")) {
				// 위키 텍스트
				wiki_text = request.getParameter("wiki_text");
				ShopWikiDTO wikiDTO = new ShopWikiDTO(product_code, product_name, wiki_text);
				int su = wikiDAO.updateWiki(wikiDTO);

				response.sendRedirect(contextPath + "/CtrlPd.do?page=pageExplain&product_code="+product_code);
			}
			
			// 상품 등록 처리
			if(page.equals("proRaiseProduct")) {
				ShopProductDTO productDTO = new ShopProductDTO();
				productDTO.setProduct_code(product_code);
				productDTO.setProduct_category(product_category);
				productDTO.setProduct_brand(product_brand);
				productDTO.setProduct_name(product_name);
				productDTO.setProduct_price(product_price);
				productDTO.setProduct_explain(product_explain);
				productDTO.setProduct_seller(product_seller);
				productDTO.setProduct_img(product_img);
				
				int su = productDAO.shop_raiseProduct(productDTO);
				// 알림창 출력 필요
				if(su != 0) {
					msg = product_seller+"님 상품 등록 완료";
				}
				else {
					msg = "상품 등록 실패";
				}
				
				response.sendRedirect(contextPath + "/CtrlPd.do?page=pageMain&msg="+URLEncoder.encode(msg, "UTF-8"));
			}
		}
	}
}