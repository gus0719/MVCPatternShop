package shop;

// SQL
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// common
import common.DbClose;
import common.DbSet;

public class ShopUserDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Statement stmt;

	String user_id;
	String user_pwd;
	String user_name;
	String user_phone;
	String user_email;
	String user_addr;
	String user_rank;
	String logChk;

	/* 사용자 정보 끌어오기 ===============================
	
	public ShopUserDTO getUserRank(String user_id) {
		String sql = "select * from SHOP_USER where user_id = ? or user_email = ?";
		ShopUserDTO dto = new ShopUserDTO();
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_rank(rs.getString("user_rank"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return dto;
	}*/

	/* 로그인 알고리즘 ( 아이디 이메일 둘다 가능 ) ===============================
	*/
	public boolean shopLogin(String id_email, String user_pwd) {
		String sql = "select * from SHOP_USER where (user_id = ? OR user_email = ?) AND user_pwd = ?";
		try {
			conn = DbSet.getConnection();

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id_email);
			pstmt.setString(2, id_email);
			pstmt.setString(3, user_pwd);

			int su = pstmt.executeUpdate();
			if (su != 0)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/* 회원가입 ===============================
	*/
	public int shop_register(ShopUserDTO shopDTO) {
		String sql = "Insert Into shop_user Values (?,?,?,?,?,?,?)";
		int su = 0;
		try {
			conn = DbSet.getConnection();

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, shopDTO.getUser_id());
			pstmt.setString(2, shopDTO.getUser_pwd());
			pstmt.setString(3, shopDTO.getUser_name());
			pstmt.setString(4, shopDTO.getUser_phone());
			pstmt.setString(5, shopDTO.getUser_email());
			pstmt.setString(6, shopDTO.getUser_addr());
			pstmt.setString(7, shopDTO.getUser_rank());

			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}

	/* 로그인 체크 ===============================
	*/
	public String logChk(String log) {
		if (log != null) {
			logChk = log;
		} else
			logChk = "3";
		return logChk;
	}

	/* 회원정보 페이지 체크 ===============================
	*/
	public ShopUserDTO myPageChk(String Id) {
		String sql = "select * from shop_user where user_id = ?";
		ShopUserDTO dto = null;

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				user_id = rs.getString("user_id");
				user_pwd = rs.getString("user_pwd");
				user_name = rs.getString("user_name");
				user_phone = rs.getString("user_phone");
				user_email = rs.getString("user_email");
				user_addr = rs.getString("user_addr");
				user_rank = rs.getString("user_rank");

				dto = new ShopUserDTO(user_id, user_pwd, user_name, user_phone, user_email, user_addr, user_rank);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return dto;
	}

	/* 회원 정보 업데이트 ===============================
	*/
	public int userUpd(String column, String up_column, String Id) {
		String sql = "update shop_user set " + column + " = '" + up_column + "' where user_id = '" + Id + "'";
		int su = 0;
		try {
			conn = DbSet.getConnection();
			stmt = conn.createStatement();
			/*
			 * System.out.println(pstmt + " <-- pstmtV01");
			 * System.out.println(pstmt.getClass() + " <-- pstmt.getClass()");
			 * 
			 * pstmt.setString(1, column); pstmt.setString(2, up_column); pstmt.setString(3,
			 * Id);
			 * 
			 * System.out.println(pstmt + " <-- pstmtV02");
			 */
			/*
			 * oracle.jdbc.driver.OraclePreparedStatementWrapper@5cdd8682 <-- pstmtV01 class
			 * oracle.jdbc.driver.OraclePreparedStatementWrapper <-- pstmt.getClass()
			 * oracle.jdbc.driver.OraclePreparedStatementWrapper@5cdd8682 <-- pstmtV02
			 */

			su = stmt.executeUpdate(sql);
			/*
			 * java.sql.SQLSyntaxErrorException << 발생 SQL Syntax의 규칙 위반
			 */
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (stmt != null || conn != null) {
				try {
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else {
				su = 404;
			}
		}
		return su;
	}

	/* 회원탈퇴 ===============================
	*/
	public int userDel(String id) {
		String sql = "delete from shop_user where user_id = ?";
		int su = 0;
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}

	/*
	 * public static void main(String[] args) { ShopUserDAO dao = new ShopUserDAO();
	 * dao.userUpd("user_id","hyo123","qwe123"); }
	 */

	/* 회원정보 찾기 =================================
	*/
	public ShopUserDTO shopFind(String vPhone) {
		ShopUserDTO dto = new ShopUserDTO();
		System.out.println(vPhone);
		try {
			conn = DbSet.getConnection();
			String sql = "select * from shop_user where user_phone = ?";
			pstmt = conn.prepareStatement(sql);
			//System.out.println(pstmt+">> pstmt1");
			pstmt.setString(1, vPhone);
			//System.out.println(pstmt+">> pstmt2");
			rs = pstmt.executeQuery();
			//System.out.println(rs);
			while(rs.next()) {
				System.out.println(rs);
				user_id=rs.getString("user_id");
				user_pwd= rs.getString("user_pwd");
				user_name=rs.getString("user_name");
				user_phone=rs.getString("user_phone");
				user_email=rs.getString("user_email");
				user_addr=rs.getString("user_addr");
				user_rank=rs.getString("user_rank");
				dto=new ShopUserDTO(user_id,user_pwd,user_name,user_phone,user_email,user_addr,user_rank);	
			}
			System.out.println(user_pwd);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return dto;
	}
}
