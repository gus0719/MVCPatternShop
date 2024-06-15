package shop;

// SQL ============================
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// common =========================
import common.DbClose;
import common.DbSet;

// Java SE 8 ======================
import java.util.ArrayList;

public class ShopBuyDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	int result;
	
	String buy_id;
	int buy_productcode;
	String buy_productname;
	String buy_productimg;
	int buy_cnt;
	int buy_price;
	String buy_addr;

	/* 상품 구매내역 추가 =======================================================
	*/
	public int shopBuy(ShopBuyDTO dto) {
		int su = 0;
		try {
			String sql = "insert into shop_buy values(?, ?, ?, ?, ?, ?, ?)";
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBuy_id());
			pstmt.setInt(2, dto.getBuy_productcode());
			pstmt.setString(3, dto.getBuy_productname());
			pstmt.setString(4, dto.getBuy_productimg());
			pstmt.setInt(5, dto.getBuy_cnt());
			pstmt.setInt(6, dto.getBuy_price());
			pstmt.setString(7, dto.getBuy_addr());
			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	
	/* 상품 구매내역 불러오기 ==================================================
	*/
	public ArrayList<ShopBuyDTO> buyList(String user_id){
		ArrayList<ShopBuyDTO> list = new ArrayList<ShopBuyDTO>();
		String sql = "select * from shop_buy where buy_id = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				buy_id = rs.getString("buy_id");
				buy_productcode = rs.getInt("buy_productcode");
				buy_productname = rs.getString("buy_productname");
				buy_productimg = rs.getString("buy_productimg");
				buy_cnt = rs.getInt("buy_cnt");
				buy_price = rs.getInt("buy_price");
				buy_addr = rs.getString("buy_addr");
				ShopBuyDTO dto = new ShopBuyDTO(buy_id, buy_productcode, buy_productname, buy_productimg,
						buy_cnt, buy_price, buy_addr);
				list.add(dto);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return list;
	}
}