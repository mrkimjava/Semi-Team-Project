package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCTemplate {
	public static Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("01. 드라이버 로드 실패");
			e.printStackTrace();
		}
		Connection con = null;
		String url = "jdbc:oracle:thin:@118.130.245.226:1521:xe";
		String id = "semi_15jijo";
		String pw = "1234";
		try {
			con = DriverManager.getConnection(url, id, pw);
			con.setAutoCommit(false); //autocommit 취소
		} catch (SQLException e) {
			System.out.println("02. DB 로그인 실패");
			e.printStackTrace();
		}		
		return con;
	}
	
	public static void closeConn(Connection con) {
		try {
			con.close();
			System.out.println("Connection close 완료");
		} catch (SQLException e) {
			System.out.println("Connection 종료 실패");
			e.printStackTrace();
		}
	}
	public static void closeStmt(Statement stmt) {
		try {
			stmt.close();
			System.out.println("Statement close 완료");
		} catch (SQLException e) {
			System.out.println("stmt 종료 실패");
			e.printStackTrace();
		}
	}
	public static void closeRs(ResultSet rs) {
		try {
			rs.close();
			System.out.println("Resultset close 완료");
		} catch (SQLException e) {
			System.out.println("ResultSet 종료 실패");
			e.printStackTrace();
		}
	}
	public static void closeAll(Connection con, Statement stmt, ResultSet rs) {
		if(con != null) {closeConn(con);}
		if(stmt != null) {closeStmt(stmt);}
		if(rs != null) {closeRs(rs);}
	}
		
	public static void commit(Connection con) {
		try {
			con.commit();
			System.out.println("commit 성공");
		} catch (SQLException e) {
			System.out.println("commit 실패");
			e.printStackTrace();
		}
	}
	public static void rollback(Connection con) {
		try {
			con.rollback();
			System.out.println("rollback 성공");
		} catch (SQLException e) {
			System.out.println("rollback 실패");
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
}
