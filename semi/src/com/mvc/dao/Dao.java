package com.mvc.dao;

import java.sql.Connection;
import java.util.ArrayList;

import com.mvc.dto.HeartDto;
import com.mvc.dto.UserDto;
import com.mvc.dto.blogDto;
import com.mvc.dto.blogHeartDto;
import com.mvc.dto.commentDto;

public interface Dao {
	
	//우저 관련 sql
	String selectUserSql = ""; // 예시) 유저 선택
	String insertUserSql = " INSERT INTO T_USER VALUES(?,USER_SEQ.NEXTVAL,SYSDATE,NULL,?,?,?,?,?,?,?,?,?,'Y',0,?,? )"; // 예시) 유저 회원가입
	String deleteUserSql = " UPDATE T_USER SET ACTIVE=?, LEAVE_DATE=SYSDATE WHERE USER_ID=?"; // 예시) 유저 삭제 -> 엑티브변경
	String updateUserSql = " UPDATE T_USER SET NAME=?, PHONE=?, EMAIL=?, PASSWD=?, NICKNAME=?, ADDRESS=?, U_NATIONAL=?, GENDER=?, AGE=? WHERE USER_ID=? "; // 예시) 유저 수정 
	String loginUserSql = " SELECT * FROM T_USER WHERE USER_ID=? AND PASSWD=? "; //로그인 유저
	String idchkSql = " SELECT * FROM T_USER WHERE USER_ID=? "; //아이디 중복체크
	
	//user dao
	public UserDto login(String id, String pw); //기본 로그인
	public String idChk(String id); // 회원가입 - id체크
	public int register(UserDto dto); //회원가입
	public int info_update(UserDto dto);//정보수정
	public int deleteUser(String id);
	
	
	
	//다른 sql문 구분
	

	//Blog
	public ArrayList<blogDto> getBlogList(Connection con);
	public int getBlogSeq(Connection con, String userid);
	public int addSchedule(Connection con, int seq, blogDto dto);
	public blogDto getblogOne(Connection con, String userid, int blogseq);
	public int delblog(Connection con, String userid, int blogseq);
	public boolean confirmblogheart(Connection con, String userid, String blogid, int blogseq);
	public int addblogheart(Connection con, String userid, String blogid, int blogseq, String title);
	public int rmblogheart(Connection con, String userid, String blogid, int blogseq);
	public ArrayList<blogHeartDto> getBlogHeart(Connection con, String userid);	
	public ArrayList<commentDto> getcommentlist(Connection con, String blogid, int blogseq);
	public int addcomment(Connection con, String blogid, int blogseq, String commentid, String content);
	public int delcomment(Connection con, String blogid, int blogseq, int commentseq);
	public int delcommentAll(Connection con, String blogid, int blogseq, int commentseq, int groupno);
	public int addanswer(Connection con, String blogid, int blogseq, String commentid, String answer, int groupno);
	
	
	//search add heart(장소찜 관련)
	public int addheart(Connection con, HeartDto dto);
	public ArrayList<HeartDto> getheart(Connection con, String userid);
	public int getheartCount(Connection con, String placeid);
	public boolean confirmheart(Connection con, String userid, String placeid);
	public int rmheart(Connection con, String userid, String placeid);
	
	
	
}
