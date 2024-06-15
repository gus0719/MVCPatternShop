package shop;

import common.DbClose;
import common.DbSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class ShopNotificationDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int notification_No;
	String notification_Subject;
	String notification_Id;
	String notification_Content;
	String notification_Date;
	
	public int notiWrite(ShopNotificationDTO notiDTO) {
		int su = 0;
		try {
			conn = DbSet.getConnection();
			String sql = "select max(Notification_No) as num from SHOP_NOTIFICATION"; // 글 레코드의 개수 확인
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int number = 1; // 아무것도 없으면 1로 설정
			if(rs.next()) {// 글이 있으면 있는만큼 + 1을 해서 번호를 부여
				number = rs.getInt("num") + 1;
			}
			sql = "insert into SHOP_NOTIFICATION(notification_no, notification_subject, notification_id, notification_content, notification_date) "
					+ "values(?, ?, ?, ?, sysdate)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, notiDTO.getNotification_Subject());
			pstmt.setString(3, notiDTO.getNotification_Id());
			pstmt.setString(4, notiDTO.getNotification_Content());			
			su = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	public ArrayList<ShopNotificationDTO> bodSelect() {
		ArrayList<ShopNotificationDTO> dtoL = new ArrayList<ShopNotificationDTO>();
		String sql = "select * from shop_notification order by NOTIFICATION_date desc";
		// 날짜를 기준으로 내림차순 정렬
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				notification_No = rs.getInt("notification_no");
				notification_Subject = rs.getString("notification_subject");
				notification_Id = rs.getString("NOTIFICATION_id");
				notification_Content = rs.getString("NOTIFICATION_CONTENT");				
				notification_Date = rs.getString("NOTIFICATION_date");				
				ShopNotificationDTO dto = new ShopNotificationDTO(notification_No, notification_Subject, notification_Id,
						notification_Content, notification_Date);
				dtoL.add(dto);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			//DbClose.close(rs, pstmt, conn);
		}
		return dtoL;
	}
	
	// ==================================== 게시판 선택
	public ShopNotificationDTO bodSelect(int bod_no) {
		ShopNotificationDTO dto = null;
		try {			
			String sql = "select * from SHOP_NOTIFICATION where notification_no = ?";
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bod_no);
			rs = pstmt.executeQuery();
			if(rs != null)
				while(rs.next()) {
					notification_No = rs.getInt("notification_no");
					notification_Subject = rs.getString("notification_subject");
					notification_Id = rs.getString("NOTIFICATION_id");
					notification_Content = rs.getString("NOTIFICATION_CONTENT");				
					notification_Date = rs.getString("NOTIFICATION_date");				
					dto = new ShopNotificationDTO(notification_No, notification_Subject, notification_Id,
							notification_Content, notification_Date);
				}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	// ==================================== 게시판 글 삭제
	public int bodDelete(ShopNotificationDTO notiDTO) {
		int su = 0;
		String sql = "DELETE FROM SHOP_NOTIFICATION WHERE notification_No = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notiDTO.getNotification_No());			
			su = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
	
	public int bodUpdate(ShopNotificationDTO dto) {
		int su = 0;		
		try {
			conn = DbSet.getConnection();
			String sql = "UPDATE SHOP_NOTIFICATION SET notification_subject = ?, notification_content = ? WHERE notification_no = ?";			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNotification_Subject());
			pstmt.setString(2, dto.getNotification_Content());				
			pstmt.setInt(3, dto.getNotification_No());		
			
			su = pstmt.executeUpdate();			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return su;
	}
}
