package com.mvc.dao;
import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserPicDao {
	
	public boolean updatetPic(String login_id, String picName) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		String query = "UPDATE T_USER SET USER_IMG = ? WHERE USER_ID = ?";

		int res = 0;
		
		try {
			pstm = con.prepareStatement(query);
			pstm.setString(1, picName);
			pstm.setString(2, login_id);
			
			res = pstm.executeUpdate();
			
			if (res > 0) {
				commit(con);
			} else {
				rollback(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeStmt(pstm);
			closeConn(con);
		}
		
		return res>0?true:false;
	}
}
