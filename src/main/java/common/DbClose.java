package common;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbClose {
	public static void close(Statement stmt, Connection conn) { // DML close
		try {
			stmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs, Statement stmt, Connection conn) { // DQL close
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}