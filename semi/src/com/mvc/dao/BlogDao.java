package com.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mvc.dto.BlognewsboardDto;
import com.mvc.dto.blogDto;

import common.JDBCTemplate;

public class BlogDao extends JDBCTemplate{
	
	//게시판 목록
	public List<BlognewsboardDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
	    List<BlognewsboardDto> res = new ArrayList<BlognewsboardDto>();
		
		String sql = " SELECT * FROM BLOG_NEWSBOARD ORDER BY SEQ DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("03.query 준비: "+sql);
			
			rs = pstm.executeQuery(sql);
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				BlognewsboardDto tmp = new BlognewsboardDto();
				tmp.setSeq(rs.getInt(1));
				tmp.setWriter(rs.getString(2));
				tmp.setTitle(rs.getString(3));
				tmp.setContent(rs.getString(4));
				tmp.setRegdate(rs.getDate(5));
				tmp.setViewcnt(rs.getInt(6));
				tmp.setRef(rs.getInt(7));
				tmp.setRe_step(rs.getInt(8));
				tmp.setRe_level(rs.getInt(9));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}
	
	//글 선택
	public BlognewsboardDto selectOne(int seq) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		BlognewsboardDto res = new BlognewsboardDto();
		
		
		
		try {
			String readsql = " UPDATE BLOG_NEWSBOARD SET VIEWCNT = VIEWCNT+1 WHERE SEQ=? ";
			pstm = con.prepareStatement(readsql);
			pstm.setInt(1, seq);
			pstm.execute();
			
			String sql = " SELECT * FROM BLOG_NEWSBOARD WHERE SEQ=? ";
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, seq);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			if(rs.next()) {
				res.setSeq(rs.getInt(1));
				res.setWriter(rs.getString(2));
				res.setTitle(rs.getString(3));
				res.setContent(rs.getString(4));
				res.setRegdate(rs.getDate(5));
				res.setViewcnt(rs.getInt(6));
				res.setRef(rs.getInt(7));
				res.setRe_step(rs.getInt(8));
				res.setRe_level(rs.getInt(9));
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}
	
	//글 추가
	public int insert(BlognewsboardDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int ref = 0;
		int re_step=1;
		int re_level=1;
		
		String sql = " INSERT INTO BLOG_NEWSBOARD VALUES(BLOG_NEWSBOARDSEQ.NEXTVAL, ?, ?, ?, SYSDATE, 0,?,?,?) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getWriter());
			pstm.setString(2, dto.getTitle());
			pstm.setString(3, dto.getContent());
			pstm.setInt(4,ref);
			pstm.setInt(5,re_step);
			pstm.setInt(6, re_level);
			
			System.out.println("03 query 준비:" + sql);
			
			ref = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(ref>0) {
				commit(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		}finally {
			closeConn(con);
			System.out.println("05. db종료\n");
		}
		return ref;
		
	}
	
	//글 수정
	public int update(BlognewsboardDto blognews) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE BLOG_NEWSBOARD SET TITLE=?, CONTENT=? WHERE SEQ=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, blognews.getTitle()); 
			pstm.setString(2,  blognews.getContent());
			pstm.setInt(3,  blognews.getSeq());
			System.out.println("03.query준비:" + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		}finally {
			closeConn(con);
			System.out.println("05. db종료\n");
		}
		return res;
	}
	
	//글 삭제
	public int delete(int seq) {
		Connection con = getConnection();
		PreparedStatement pstm= null;
		int res = 0;
		
		String sql = " DELETE FROM BLOG_NEWSBOARD WHERE SEQ=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, seq);
			System.out.println("03. query 준비: " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			closeConn(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	
	//모든 게시글 리턴
	public List<BlognewsboardDto> selectAll(int startRow, int endRow){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
	    List<BlognewsboardDto> res = new ArrayList<BlognewsboardDto>();
		
		String sql = " SELECT * FROM (SELECT A.*,ROWNUM RNUM FROM (SELECT * FROM BLOG_NEWSBOARD ORDER BY SEQ DESC)A) WHERE RNUM >=? AND RNUM <=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, startRow);
			pstm.setInt(2, endRow);
			
			rs = pstm.executeQuery();
			System.out.println("03.query 준비: "+sql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			
			while(rs.next()) {
				BlognewsboardDto tmp = new BlognewsboardDto();
				tmp.setSeq(rs.getInt(1));
				tmp.setWriter(rs.getString(2));
				tmp.setTitle(rs.getString(3));
				tmp.setContent(rs.getString(4));
				tmp.setRegdate(rs.getDate(5));
				tmp.setViewcnt(rs.getInt(6));
				tmp.setRef(rs.getInt(7));
				tmp.setRe_step(rs.getInt(8));
				tmp.setRe_level(rs.getInt(9));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
				
	}
	//전체 글 갯수 리턴
	public int getAllCount() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int count = 0;
		
		String sql = " SELECT COUNT(*) FROM BLOG_NEWSBOARD ";
		
		try {
			pstm = con.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
		}
		return count;
	}
	
	//메인에 조회수 순 3개 출력
	public List<BlognewsboardDto> toprank(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BlognewsboardDto> res = new ArrayList<BlognewsboardDto>();
		
		String sql = " SELECT * FROM BLOG_NEWSBOARD ORDER BY VIEWCNT DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("03.query 준비: "+sql);
			
			rs = pstm.executeQuery(sql);
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				BlognewsboardDto tmp = new BlognewsboardDto();
				tmp.setSeq(rs.getInt(1));
				tmp.setWriter(rs.getString(2));
				tmp.setTitle(rs.getString(3));
				tmp.setRegdate(rs.getDate(5));
				tmp.setViewcnt(rs.getInt(6));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}
	
	//블로그 게시판 
	public List<blogDto> scheduleboardlist(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<blogDto> res = new ArrayList<blogDto>();
		
		String sql = " SELECT * FROM V_BLOG_LIST_DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("03.query 준비: "+sql);
			
			rs = pstm.executeQuery(sql);
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				blogDto tmp = new blogDto();
				tmp.setUser_id(rs.getString(1));
				tmp.setUser_penalty(rs.getInt(2));
				tmp.setBlog_seq(rs.getInt(3));
				tmp.setTitle(rs.getString(5));
				tmp.setMindate(rs.getDate(8));
				tmp.setMaxdate(rs.getDate(9));
				tmp.setThumbnailPath(rs.getString(10));
				tmp.setHeart_count(rs.getInt(11));
				tmp.setComment(rs.getInt(12));
				tmp.setHits(rs.getInt(13));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}

	//블로그 게시판 베스트
	public List<blogDto> bestlist(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<blogDto> res = new ArrayList<blogDto>();
		
		String sql = " SELECT * FROM V_BLOG_LIST ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("03.query 준비: "+sql);
			
			rs = pstm.executeQuery(sql);
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				blogDto tmp = new blogDto();
				tmp.setBlog_seq(rs.getInt(3));
				tmp.setUser_id(rs.getString(1));
				tmp.setTitle(rs.getString(5));
				tmp.setMindate(rs.getDate(8));
				tmp.setMaxdate(rs.getDate(9));
				tmp.setThumbnailPath(rs.getString(10));
				tmp.setHeart_count(rs.getInt(11));
				tmp.setComment(rs.getInt(12));
				tmp.setHits(rs.getInt(13));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}	
	
	//블로그상세리스트 페이징
	public List<blogDto> scheduleboardlist(int startRow,int endRow){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<blogDto> res = new ArrayList<blogDto>();
		String sql = " SELECT * FROM (SELECT A.*,ROWNUM RNUM FROM (SELECT * FROM V_BLOG_LIST ORDER BY HITS_COUNT DESC)A) WHERE RNUM >=? AND RNUM <=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, startRow);
			pstm.setInt(2, endRow);
			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				blogDto tmp = new blogDto();
				tmp.setUser_id(rs.getString(1));
				tmp.setUser_penalty(rs.getInt(2));
				tmp.setBlog_seq(rs.getInt(3));
				tmp.setTitle(rs.getString(5));
				tmp.setMindate(rs.getDate(8));
				tmp.setMaxdate(rs.getDate(9));
				tmp.setThumbnailPath(rs.getString(10));
				tmp.setHeart_count(rs.getInt(11));
				tmp.setComment(rs.getInt(12));
				tmp.setHits(rs.getInt(13));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}
	//전체 글 갯수 리턴
	public int ScheduleboardAllCount() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int count = 0;
		
		String sql = " SELECT COUNT(*) FROM V_BLOG_LIST_DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeAll(con,pstm,rs);
		}
		return count;
	}
	
	

	
	
	
	
	
	
}