package com.mvc.biz;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.mvc.dao.DaoImpl;
import com.mvc.dto.HeartDto;
import com.mvc.dto.UserDto;
import com.mvc.dto.blogDto;
import com.mvc.dto.blogHeartDto;
import com.mvc.dto.commentDto;

public class BizImpl implements MVCBiz{
	
	Connection con;
	DaoImpl dao = new DaoImpl();

	//유저관련
	@Override
	public UserDto selectUser() {
		
		
		return null;
	}

	@Override
	public boolean insertUser() {
		
		
		return false;
	}

	@Override
	public boolean deleteUser() {
		
		
		return false;
	}

	@Override
	public boolean updateUser() {
		
		
		return false;
	}

	
	//블로그관련------------------------------------------------------------------------------
	@Override
	public ArrayList<blogDto> getBlogList() {
		
		con = getConnection();
		ArrayList<blogDto> list = dao.getBlogList(con);
		closeConn(con);
		
		return list;
	}

	@Override
	public int addSchedule(blogDto dto) {
		
		con = getConnection();
		int seq = dao.getBlogSeq(con, dto.getUser_id()) + 1;
		int res = dao.addSchedule(con, seq, dto);
		if(res > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		closeConn(con);
		
		return res;
	}
	
	@Override
	public blogDto getblogOne(String userid, int blogseq) {
		
		con = getConnection();
		blogDto bdto = dao.getblogOne(con, userid, blogseq);
		closeConn(con);
		
		return bdto;
	}
	
	@Override
	public int delblog(String userid, int blogseq) {
		
		con = getConnection();
		int res = dao.delblog(con, userid, blogseq);
		closeConn(con);
		
		return res;
	}
	
	@Override
	public boolean confirmblogheart(String userid, String blogid, int blogseq) {
		
		con = getConnection();
		boolean res = dao.confirmblogheart(con, userid, blogid, blogseq);
		closeConn(con);
		
		return res;
	}

	@Override
	public int addblogheart(String userid, String blogid, int blogseq, String title) {
		con = getConnection();
		int res = dao.addblogheart(con, userid, blogid, blogseq, title);
		if(res != 0) {
			commit(con);
		}else {
			rollback(con);
		}
		closeConn(con);
		
		return res;
	}

	@Override
	public int rmblogheart(String userid, String blogid, int blogseq) {
		
		con = getConnection();
		int res = dao.rmblogheart(con, userid, blogid, blogseq);
		if(res != 0) {
			commit(con);
		}else {
			rollback(con);
		}
		closeConn(con);
		
		return res;
	}

	@Override
	public ArrayList<blogHeartDto> getBlogHeart(String userid) {
		
		con = getConnection();
		ArrayList<blogHeartDto> list = dao.getBlogHeart(con, userid);
		closeConn(con);
		
		return list;
	}
	
	
	//-------------blogcomment
	@Override
	public ArrayList<commentDto> getcommentlist(String blogid, int blogseq) {
		
		con = getConnection();
		ArrayList<commentDto> list = dao.getcommentlist(con, blogid, blogseq);
		closeConn(con);
		
		return list;
	}
	
	@Override
	public ArrayList<commentDto> addcomment(String blogid, int blogseq, String commentid, String content) {
		
		con = getConnection();
		int res = dao.addcomment(con, blogid, blogseq, commentid, content);
		if(res == 0) {
			rollback(con);
			closeConn(con);
			return null;
		}
		ArrayList<commentDto> list = dao.getcommentlist(con, blogid, blogseq);
		commit(con);
		closeConn(con);
		
		return list;
	}
	
	@Override
	public ArrayList<commentDto> delcomment(String blogid, int blogseq, int commentseq, int groupno, int groupseq) {
		con = getConnection();
		int res = 0;
		
		if(groupseq != 1) {
			res = dao.delcomment(con, blogid, blogseq, commentseq);
		}else {
			res = dao.delcommentAll(con, blogid, blogseq, commentseq, groupno);
		}
		if(res == 0) {
			rollback(con);
			closeConn(con);
			return null;
		}
		ArrayList<commentDto> list = dao.getcommentlist(con, blogid, blogseq);
		commit(con);
		closeConn(con);
		
		return list;
	}
	
	@Override
	public ArrayList<commentDto> addanswer(String blogid, int blogseq, String commentid, String answer, int groupno) {

		con = getConnection();
		int res = dao.addanswer(con, blogid, blogseq, commentid, answer, groupno);
		if(res == 0) {
			rollback(con);
			closeConn(con);
			return null;
		}
		ArrayList<commentDto> list = dao.getcommentlist(con, blogid, blogseq);
		commit(con);
		closeConn(con);
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//찜관련------------------------------------------------------------------------------
	
	//OPEN 시 특정 유저가 찜했는지 여부
	@Override
	public boolean confirmheart(String userid, String placeid) {
		
		con = getConnection();
		boolean res = dao.confirmheart(con, userid, placeid);
		closeConn(con);
		
		return res;
	}
	
	//OPEN 시 특정 장소를 찜한 사람 수 반환 (매개변수 : placeid)
	@Override
	public int getheartCount(String placeid) {
		
		con = getConnection();
		int res = dao.getheartCount(con, placeid);
		closeConn(con);
		
		return res;
	}
	
	
	//add heart(장소 찜)
	@Override
	public int addheart(HeartDto dto) {
		
		con = getConnection();
		int res = dao.addheart(con, dto);
		if(res != -1) {
			commit(con);
		}else {
			rollback(con);
		}
		closeConn(con);
		
		return res;
	}
	
	//rm heart (찜 삭제)
	@Override
	public int rmheart(String userid, String placeid) {
		
		con = getConnection();
		int res = dao.rmheart(con, userid, placeid);
		if(res != -1) {
			commit(con);
		}else {
			rollback(con);
		}
		closeConn(con);
		
		return res;
	}
	
	
	
	//찜 목록 가져오기 (heart dto 리스트) 매개변수 : userid NATION/CITY
	@Override
	public ArrayList<HeartDto> getHeart(String userid) {
		
		con = getConnection();
		ArrayList<HeartDto> heartlist = dao.getheart(con, userid);
		closeConn(con);
		
		return heartlist;
	}























	
	
	

}


















