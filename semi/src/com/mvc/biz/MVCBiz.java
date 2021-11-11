package com.mvc.biz;

import java.sql.Connection;
import java.util.ArrayList;

import com.mvc.dto.HeartDto;
import com.mvc.dto.UserDto;
import com.mvc.dto.blogDto;
import com.mvc.dto.blogHeartDto;
import com.mvc.dto.commentDto;

public interface MVCBiz {
	
	public UserDto selectUser();
	public boolean insertUser();
	public boolean deleteUser();
	public boolean updateUser();
	
	//블로그관련
	public ArrayList<blogDto> getBlogList();
	public int addSchedule(blogDto dto);
	public blogDto getblogOne(String userid, int blogseq);
	public int delblog(String userid, int blogseq);
	public boolean confirmblogheart(String userid, String blogid, int blogseq);
	public int addblogheart(String userid, String blogid, int blogseq, String title);
	public int rmblogheart(String userid, String blogid, int blogseq);
	public ArrayList<blogHeartDto> getBlogHeart(String userid);
	public ArrayList<commentDto> getcommentlist(String blogid, int blogseq);
	public ArrayList<commentDto> addcomment(String blogid, int blogseq, String commentid, String content);
	public ArrayList<commentDto> delcomment(String blogid, int blogseq, int commentseq, int groupno, int groupseq);
	public ArrayList<commentDto> addanswer(String blogid, int blogseq, String commentid, String answer, int groupno);
	
	
	
	
	//search.jsp 장소heart
	public int addheart(HeartDto dto);
	public ArrayList<HeartDto> getHeart(String userid);
	public int getheartCount(String placeid);
	public boolean confirmheart(String userid, String placeid);
	public int rmheart(String userid, String placeid);
	
	
}
