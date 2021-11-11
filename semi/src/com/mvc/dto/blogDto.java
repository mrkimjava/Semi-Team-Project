package com.mvc.dto;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;

public class blogDto {
	private String user_id;
	private int user_penalty; //user_penaly;
	private int blog_seq;
	private Date blog_create_date;
	private String title;
	private String content;
	private String areaname;
	private LinkedHashMap<Date, String> map;
	private Date maxdate;
	private Date mindate;
	private String thumbnailPath; //썸네일 경로
	private int heart_count; //찜수 디폴트 0
	private int comment; //댓글수 디폴트 0
	private int hits;	//글 조회수 디폴트 1
	
	
	public blogDto() {
		map = new LinkedHashMap<Date, String>();
	}

	public blogDto(String user_id, int user_penalty, int blog_seq, Date blog_create_date, String title, String content,
			String areaname, LinkedHashMap<Date, String> map, Date maxdate, Date mindate, String thumbnailPath,
			int heart_count, int comment, int hits) {
		super();
		this.user_id = user_id;
		this.user_penalty = user_penalty;
		this.blog_seq = blog_seq;
		this.blog_create_date = blog_create_date;
		this.title = title;
		this.content = content;
		this.areaname = areaname;
		this.map = map;
		this.maxdate = maxdate;
		this.mindate = mindate;
		this.thumbnailPath = thumbnailPath;
		this.heart_count = heart_count;
		this.comment = comment;
		this.hits = hits;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getUser_penalty() {
		return user_penalty;
	}

	public void setUser_penalty(int user_penalty) {
		this.user_penalty = user_penalty;
	}

	public int getBlog_seq() {
		return blog_seq;
	}

	public void setBlog_seq(int blog_seq) {
		this.blog_seq = blog_seq;
	}

	public Date getBlog_create_date() {
		return blog_create_date;
	}

	public void setBlog_create_date(Date blog_create_date) {
		this.blog_create_date = blog_create_date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAreaname() {
		return areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public LinkedHashMap<Date, String> getMap() {
		return map;
	}

	public void setMap(LinkedHashMap<Date, String> map) {
		this.map = map;
	}

	public Date getMaxdate() {
		return maxdate;
	}

	public void setMaxdate(Date maxdate) {
		this.maxdate = maxdate;
	}

	public Date getMindate() {
		return mindate;
	}

	public void setMindate(Date mindate) {
		this.mindate = mindate;
	}

	public String getThumbnailPath() {
		return thumbnailPath;
	}

	public void setThumbnailPath(String thumbnailPath) {
		this.thumbnailPath = thumbnailPath;
	}

	public int getHeart_count() {
		return heart_count;
	}

	public void setHeart_count(int heart_count) {
		this.heart_count = heart_count;
	}

	public int getComment() {
		return comment;
	}

	public void setComment(int comment) {
		this.comment = comment;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	
	
	
}
