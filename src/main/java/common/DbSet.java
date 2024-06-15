package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbSet {
	public static Connection getConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String uId = "hr";
		String uPwd = "hr";
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); // 1단계. 드라이버 로드
			conn = DriverManager.getConnection(url, uId, uPwd); // 2단계. url DB연동
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return conn; // url 연동된 Connection 반환
	}
}