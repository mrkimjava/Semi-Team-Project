package com.mvc.dto;

import java.util.Date;

public class blogHeartDto {
	private Date regdate;
	private String userid;
	private String blogid;
	private int blogseq;
	private String title;
	private String blogNickname;
	
	public blogHeartDto() {}
	
	public blogHeartDto(Date regdate, String userid, String blogid, int blogseq, String title, String blogNickname) {
		super();
		this.regdate = regdate;
		this.userid = userid;
		this.blogid = blogid;
		this.blogseq = blogseq;
		this.title = title;
		this.blogNickname = blogNickname;
	}
	

	public String getBlogNickname() {
		return blogNickname;
	}

	public void setBlogNickname(String blogNickname) {
		this.blogNickname = blogNickname;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBlogid() {
		return blogid;
	}

	public void setBlogid(String blogid) {
		this.blogid = blogid;
	}

	public int getBlogseq() {
		return blogseq;
	}

	public void setBlogseq(int blogseq) {
		this.blogseq = blogseq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	
}
