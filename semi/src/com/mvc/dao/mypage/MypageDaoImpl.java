package com.mvc.dao.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.mvc.dto.HeartDto;
//import com.mvc.dto.Paging;
import com.mvc.dto.PromiseDto;
import com.mvc.dto.UserDto;
import com.mvc.dto.blogDto;
import com.mvc.dto.blogHeartDto;

import common.JDBCTemplate;

public class MypageDaoImpl extends JDBCTemplate implements MypageDao{

	@Override
	public List<blogDto> selectTravel(String user_id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<blogDto> res = new ArrayList<blogDto>();
		//select * from v_blog_list where user_id=?;
		
		try {
			pstm = con.prepareStatement(selectTravelSql);
			pstm.setString(1, user_id);
			System.out.println("03. query준비 : "+selectTravelSql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				blogDto tmp = new blogDto();
				tmp.setUser_id(rs.getString("USER_ID"));
				tmp.setUser_penalty(rs.getInt("PENALTY"));
				tmp.setBlog_seq(rs.getInt("BLOG_SEQ"));
				tmp.setBlog_create_date(rs.getDate("BLOG_CREATE_DATE"));
				tmp.setTitle(rs.getString("TITLE"));
				tmp.setContent(rs.getString("CONTENT"));
				tmp.setAreaname(rs.getString("AREA_NAME"));
				tmp.setMindate(rs.getDate("MINDATE"));
				tmp.setMaxdate(rs.getDate("MAXDATE"));
				tmp.setThumbnailPath(rs.getString("IMG_PATH"));
				tmp.setHeart_count(rs.getInt("HEART_COUNT"));
				tmp.setComment(rs.getInt("COMMENT_COUNT"));
				tmp.setHits(rs.getInt("HITS_COUNT"));
				
				res.add(tmp);
				}
			
			
			} catch (SQLException e) {
				System.out.println("3/4단계 에러");
				e.printStackTrace();
			}finally {
				closeAll(con, pstm, rs);
				System.out.println("05. db종료\n");
			}
			
		
		return res;
	}

	@Override
	public List<HeartDto> selectWished(String user_id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<HeartDto> res = new ArrayList<HeartDto>();
		
		try {
			pstm = con.prepareStatement(selectWishedSql);
			pstm.setString(1, user_id);
			System.out.println("03.query 준비 : "+selectCompanionSql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				HeartDto tmp = new HeartDto();
				tmp.setUserid(rs.getString("USER_ID"));
				tmp.setPlace_id(rs.getString("PLACE_ID"));
				tmp.setThumbnail(rs.getString("THUMBNAIL"));
				tmp.setPlace_name(rs.getString("PLACE_NAME"));
				tmp.setLatitude(rs.getString("LATITUDE"));
				tmp.setLongtitude(rs.getString("LONGITUDE"));
				tmp.setPlace_address(rs.getString("PLACE_ADDRESS"));
				tmp.setNation(rs.getString("NATION"));
				tmp.setCity(rs.getString("CITY"));
				
				res.add(tmp);

			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		}finally {
			closeAll(con, pstm, rs);
			
		}
		
		return res;
		
	}

	@Override
	public List<PromiseDto> selectCompanion(String user_id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<PromiseDto> res = new ArrayList<PromiseDto>();
		
		try {
			pstm = con.prepareStatement(selectCompanionSql);
			pstm.setString(1, user_id);
			pstm.setString(2, user_id);
			System.out.println("03.query 준비 : "+selectCompanionSql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				PromiseDto tmp = new PromiseDto();
				tmp.setP_seq(rs.getInt("P_SEQ"));
				tmp.setSen_id(rs.getString("SEN_ID"));
				tmp.setRec_id(rs.getString("REC_ID"));
				tmp.setP_loc(rs.getString("P_LOC"));
				tmp.setP_time(rs.getString("P_TIME"));
				tmp.setP_comment(rs.getString("P_COMMENT"));
				
				res.add(tmp);
			}
			
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		}finally {
			closeAll(con, pstm, rs);
			System.out.println("05. db종료\n");
		}
				
		return res;
	}

	@Override
	public List<blogHeartDto> selectWishedBlog(String user_id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<blogHeartDto> res = new ArrayList<blogHeartDto>();
		//select * from v_blog_list where user_id=?;
		
		try {
			pstm = con.prepareStatement(selectWishedBSql);
			pstm.setString(1, user_id);
			System.out.println("03. query준비 : "+selectWishedBSql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				blogHeartDto tmp = new blogHeartDto();
				tmp.setRegdate(rs.getDate(1));
				tmp.setUserid(rs.getString(2));
				tmp.setBlogid(rs.getString(3));
				tmp.setBlogseq(rs.getInt(4));
				tmp.setBlogNickname(rs.getString(5));
				
				res.add(tmp);
				}
			
			
			} catch (SQLException e) {
				System.out.println("3/4단계 에러");
				e.printStackTrace();
			}finally {
				closeAll(con, pstm, rs);
				System.out.println("05. db종료\n");
			}

		return res;
	
	}


	
}
