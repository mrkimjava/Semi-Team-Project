package com.mvc.dao.mypage;

import java.util.List;

import com.mvc.dto.HeartDto;
import com.mvc.dto.PromiseDto;
import com.mvc.dto.blogDto;
import com.mvc.dto.blogHeartDto;

public interface MypageDao {

	String selectTravelSql = " SELECT * FROM V_BLOG_LIST WHERE USER_ID=? ORDER BY BLOG_CREATE_DATE DESC "; // 내 여행 조회
	//String deleteTravelSql = " DELETE FROM V_BLOG_LIST WHERE USER_ID=? AND BLOG_SEQ=? "; // 내 여행 삭제

	String selectWishedBSql = " SELECT * FROM BLOG_HEART WHERE USER_ID=? ORDER BY REG_DATE DESC "; //블로그찜 조회
	
	String selectWishedSql = " SELECT * FROM PLACE_HEART WHERE USER_ID=? ORDER BY NATION, CITY "; // 찜한 여행 조회
	//String deleteWishedSql = " DELTE FROM PLACE_HEART WHERE USER_ID =? AND BLOG_ID=? "; // 찜한 여행 삭제
	
	String selectCompanionSql = " SELECT * FROM M_PROMISE WHERE (SEN_ID=? OR REC_ID=?) AND PERMIT='Y' "; // 동행 조회
	//String deleteCompanionSql = "  "; // 동행 삭제
	

	public List<blogDto> selectTravel(String user_id);
	public List<blogHeartDto> selectWishedBlog(String user_id);
	public List<HeartDto> selectWished(String user_id);
	public List<PromiseDto> selectCompanion(String user_id);
	
	
//	public boolean deleteTravel(int seq);
//	public boolean deleteWished(int seq);
//	public boolean deleteCompanion(int seq);
//	
	
	
}
