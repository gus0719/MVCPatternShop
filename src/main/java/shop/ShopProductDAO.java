package shop;

// common ====================
import common.DbClose;
import common.DbSet;

// sql =======================
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;

// Java SE 8
import java.util.ArrayList;

public class ShopProductDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	int product_code; // 상품코드
	String product_category; // 카테고리
	String product_brand; // 브랜드
	String product_name; // 상품명
	int product_price; // 상품가격
	String product_explain; // 상품설명
	String product_seller; // 판매자
	String product_date; // 등록일
	String product_img; // 상품이미지

	/* ResultSet -> ArrayList 반환 메소드 ============================
	*/
	private ArrayList<ShopProductDTO> rsToArrayList(ResultSet resultSet){
		ArrayList<ShopProductDTO> list = new ArrayList<ShopProductDTO>();
		try {
			while(resultSet.next()) {
				product_code = rs.getInt("product_code");
				product_category = rs.getString("product_category");
				product_brand = rs.getString("product_brand");
				product_name = rs.getString("product_name");
				product_price = rs.getInt("product_price");
				product_explain = rs.getString("product_explain");
				product_seller = rs.getString("product_seller");
				product_date = rs.getString("product_date");
				product_img = rs.getString("product_img");
				ShopProductDTO dto = new ShopProductDTO(
						product_code,
						product_category,
						product_brand,
						product_name,
						product_price,
						product_explain,
						product_seller, product_date, product_img);
				list.add(dto);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/* 카테고리별 브랜드 추출 메소드 ============================================
	*/
	public ArrayList<String> shop_categories(String category){
		ArrayList<String> categories = new ArrayList<String>();
		String sql = "select distinct product_brand from shop_product "
				+ "where product_category = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			while(rs.next())
				categories.add(rs.getString("product_brand"));
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return categories;
	}
	
	/* 상품 등록 메소드 ============================================
	*/
	public int shop_raiseProduct(ShopProductDTO productDTO) {
		int su = 0;
		product_category = productDTO.getProduct_category();
		product_brand = productDTO.getProduct_brand();
		product_name = productDTO.getProduct_name();
		product_price = productDTO.getProduct_price();
		product_explain = productDTO.getProduct_explain();
		product_seller = productDTO.getProduct_seller();
		product_img = productDTO.getProduct_img();
		try {
			conn = DbSet.getConnection();
			String sql = "select max(product_code) as num from SHOP_PRODUCT";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int number = 1;
			if(rs != null) {
				while(rs.next())
					number = rs.getInt("num") + 1; // 상품코드 지정
			}
			
			sql = "insert into SHOP_PRODUCT "
					+ "values(?, ?, ?, ?, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, product_category);
			pstmt.setString(3, product_brand);
			pstmt.setString(4, product_name);
			pstmt.setInt(5, product_price);
			pstmt.setString(6, product_explain);
			pstmt.setString(7, product_seller);
			pstmt.setString(8, product_img);
			su = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return su;
	}
	
	
	/* 카테고리 상품 목록 반환 ======================================================
	*/
	public ArrayList<ShopProductDTO> categorySel(String category){
		ArrayList<ShopProductDTO> categoryList = new ArrayList<ShopProductDTO>();
		String sql = "select * from shop_product where product_category = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			categoryList = rsToArrayList(rs);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return categoryList;
	}
	
	/* 브랜드 상품 목록 반환 =================================================
	*/
	public ArrayList<ShopProductDTO> brandSel(String brand){
		ArrayList<ShopProductDTO> brandList = new ArrayList<ShopProductDTO>();
		String sql = "select * from shop_product "
				+ "where product_brand = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			rs = pstmt.executeQuery();
			brandList = rsToArrayList(rs);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return brandList;
	}
	
	/* 카테고리, 브랜드 상품 목록 반환 =================================================
	*/
	public ArrayList<ShopProductDTO> categoryToBrandSel(String category, String brand){
		ArrayList<ShopProductDTO> brandList = new ArrayList<ShopProductDTO>();
		String sql = "select * from shop_product "
				+ "where product_category = ? AND product_brand = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, brand);
			rs = pstmt.executeQuery();
			brandList = rsToArrayList(rs);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return brandList;
	}
	
	/* 상품 정보 반환 ==============================================================
	*/
	public ShopProductDTO getProduct(int product_code) {
		String sql = "select * from shop_product "
				+ "where product_code = ?";
		ShopProductDTO product = new ShopProductDTO();
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				product_code = rs.getInt("product_code");
				product_category = rs.getString("product_category");
				product_brand = rs.getString("product_brand");
				product_name = rs.getString("product_name");
				product_price = rs.getInt("product_price");
				product_explain = rs.getString("product_explain");
				product_seller = rs.getString("product_seller");
				product_date = rs.getString("product_date");
				product_img = rs.getString("product_img");
				product = new ShopProductDTO(
						product_code,
						product_category,
						product_brand,
						product_name,
						product_price,
						product_explain,
						product_seller, product_date, product_img);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return product;
	}
	
	/* 상품 위키 반환 ===================================================
	*/
	@Deprecated
	public String getWikiOfProduct(int product_code) {
		String wiki = "";
		String sql = "select * "
				+ "from shop_product inner join shop_wiki "
				+ "on product_code = wiki_code AND product_code = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_code);
			rs = pstmt.executeQuery();
			while(rs.next())
				wiki = rs.getString("wiki_text");
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return wiki;
	}
	
	/* 구매율 top 5 ===================================================
	*/
	public ArrayList<Integer> getTop5() {
		//ArrayList<ShopProductDTO> top5Products = new ArrayList<ShopProductDTO>();
		ArrayList<Integer> top5Products = new ArrayList<Integer>();
		String sql = "SELECT buy_productcode, COUNT(*) AS purchase_count " +
		             "FROM shop_buy " +
		             "GROUP BY buy_productcode " +
		             "ORDER BY purchase_count DESC ";
		             //"FETCH FIRST 1 ROWS ONLY";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int productCode = rs.getInt("buy_productcode");
				//ShopProductDTO product = getProduct(productCode);
				top5Products.add(productCode);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				DbClose.close(rs, pstmt, conn);
			} else {
				DbClose.close(pstmt, conn);
			}
		}
		return top5Products;
	}
	
	/* 특정 가격 이하 상품 목록 ===================================================
	*/
	public ArrayList<ShopProductDTO> lessThanPrice(int price){
		ArrayList<ShopProductDTO> lessThanProducts = new ArrayList<ShopProductDTO>();
		String sql = "select * from shop_product "
				+ "where product_price <= ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, price);
			rs = pstmt.executeQuery();
			lessThanProducts = rsToArrayList(rs);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return lessThanProducts;
	}
	
	/* 랜덤 상품 =======================================
	*/
	public int[] randomProduct() {
		ArrayList<Integer> list = new ArrayList<Integer>();
		int size = 0;
		int[] randomArr = null;
		String sql = "select product_code from shop_product";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getInt("product_code"));
			}
			size = list.size();
			randomArr = new int[(size < 6) ? size : 6];
			randomArr[0] = list.get((int)(Math.random() * size));
			label : for(int outer = 1; outer < randomArr.length; outer++) {
				randomArr[outer] = list.get((int)(Math.random() * size));
				for(int inner = outer - 1; inner >= 0; inner--) {
					if(randomArr[outer] == randomArr[inner]) {
						outer--;
						continue label;
					}
				}
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return randomArr;
	}
	
	/* 상품 검색 알고리즘 ================================================
	*/
	public ArrayList<ShopProductDTO> searchProductName (String name){
		ArrayList<ShopProductDTO> searchList = new ArrayList<ShopProductDTO>();
		String sql = "select * from shop_product where product_name like ? or product_brand like ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+name+"%");
			pstmt.setString(2, "%"+name+"%");
			rs = pstmt.executeQuery();
			searchList = rsToArrayList(rs);
			//System.out.println(searchList.size() + "test003");
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return searchList;
	}
	
	/* 검색창 자동완성 ================================================
	*/
	public ArrayList<String> autoCompleteName(String name) {
		ArrayList<String> items = new ArrayList<String>();
		String sql = "select distinct product_name from shop_product where product_name like ? or product_brand like ?";
		if(name.equals("") || name.equals(" ")) { // 검색어에 공백 입력 시 에러
			items.add("검색어가 없어요");
			return items;
		}
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+name+"%");
			pstmt.setString(2, "%"+name+"%");
			rs = pstmt.executeQuery();
			//items.add(rs.getString("product_brand"));
			while(rs.next()) {
				items.add(rs.getString("product_name"));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return items;
	}
}