package shop;

//SQL
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//common
import common.DbClose;
import common.DbSet;

// Java SE 8
import java.util.ArrayList;

public class ShopCartDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	/* 장바구니 상품 등록 ===================================
	*/
	public int putInCart(ShopCartDTO dto) {
		int su = 0;
		String sql = "insert into shop_cart "
				+ "values(?, ?, ?, ?, ?)";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCart_id());
			pstmt.setInt(2, dto.getCart_code());
			pstmt.setString(3, dto.getCart_product_name());
			pstmt.setString(4, dto.getCart_product_img());
			pstmt.setInt(5, dto.getCart_num());
			su = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	
	/* 장바구니 상품 삭제 ================================
	*/
	public int delItem(String user_id, int product_code) {
		int su = 0;
		String sql = "delete from shop_cart "
				+ "where cart_id = ? and cart_code = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, product_code);
			su = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	
	/* 장바구니 상품 목록 출력 ================================
	*/
	public ArrayList<ShopCartDTO> getFromCart(String user_id){
		ArrayList<ShopCartDTO> items = new ArrayList<ShopCartDTO>();
		String sql = "select * from shop_cart where cart_id = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String id = rs.getString("cart_id");
				int code = rs.getInt("cart_code");
				String name = rs.getString("cart_product_name");
				String img = rs.getString("cart_product_img");
				int num = rs.getInt("cart_num");
				ShopCartDTO dto = new ShopCartDTO(id, code, name, img, num);
				items.add(dto);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) DbClose.close(rs, pstmt, conn);
			else DbClose.close(pstmt, conn);
		}
		return items;
	}
}