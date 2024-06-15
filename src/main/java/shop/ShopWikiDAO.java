package shop;

//SQL
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//common
import common.DbClose;
import common.DbSet;

public class ShopWikiDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	/* 위키 업데이트 (데이터 없으면 삽입) ==========================
	*/
	public int updateWiki(ShopWikiDTO dto){
		int su = 0;
		
		String sql = "update shop_wiki "
				+ "set wiki_text = ? "
				+ "where wiki_code = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWiki_text());
			pstmt.setInt(2, dto.getWiki_code());
			su = pstmt.executeUpdate();
			if(su == 0) { // 위키 내용 없으면 삽입
				sql = "insert into shop_wiki "
						+ "values(?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getWiki_code());
				pstmt.setString(2, dto.getWiki_product_name());
				pstmt.setString(3, dto.getWiki_text());
				su = pstmt.executeUpdate();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	
	/* 위키 텍스트 추출 =========================================
	*/
	public String getWikiOfCode(int product_code) {
		String wiki_text = "";
		String sql = "select wiki_text from shop_wiki where wiki_code = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_code);
			rs = pstmt.executeQuery();
			while(rs.next())
				wiki_text = rs.getString("wiki_text");
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return wiki_text;
	}
}