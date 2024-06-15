package shop;

// SQL
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// common
import common.DbClose;
import common.DbSet;

// Java SE 8
import java.util.ArrayList;

public class ShopInterestDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	/* 관심상품 추가 ===================================
	*/
	public int appendInterest(ShopInterestDTO dto) {
		int su = 0;
		String sql = "insert into shop_interest "
				+ "values(?, ?, ?, ?)";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getInterest_id());
			pstmt.setInt(2, dto.getInterest_productcode());
			pstmt.setString(3, dto.getInterest_product_name());
			pstmt.setString(4, dto.getInterest_product_img());
			su = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	
	
	/* 관심상품 상태 확인
	*/
	public int interestState(String user_id, int product_code) {
		int su = 0;
		String sql = "select * from shop_interest "
				+ "where interest_id = ? "
				+ "and interest_product_code = ?";
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
	
	/* 관심상품 삭제 =============================
	*/
	public int delInterest(String user_id, int product_code) {
		int su = 0;
		String sql = "delete from shop_interest "
				+ "where interest_id = ? "
				+ "and interest_product_code = ?";
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
	
	/* 관심상품 목록 출력 ==============================================
	*/
	public ArrayList<ShopInterestDTO> interestList(String user_id){
		ArrayList<ShopInterestDTO> items = new ArrayList<ShopInterestDTO>();
		String sql = "select * from shop_interest "
				+ "where interest_id = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String interest_id = rs.getString("interest_id");
				int interest_code = rs.getInt("interest_product_code");
				String interest_name = rs.getString("interest_product_name");
				String interest_img = rs.getString("interest_product_img");
				ShopInterestDTO iDTO = new ShopInterestDTO(
						interest_id, interest_code, interest_name, interest_img);
				items.add(iDTO);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return items;
	}
}