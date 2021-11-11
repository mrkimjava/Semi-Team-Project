package com.mvc.dto;

import java.util.Date;

public class commentDto {
	
	private String blogid;
	private int blogseq;
	private Date commentDate;
	private int commentseq;
	private int groupno;
	private int groupseq;
	private int titletab;
	private String commentid;
	private String content;
	
	
	public commentDto() {}
	
	public commentDto(String blogid, int blogseq, Date commentDate, int commentseq, int groupno, int groupseq,
			int titletab, String commentid, String content) {
		super();
		this.blogid = blogid;
		this.blogseq = blogseq;
		this.commentDate = commentDate;
		this.commentseq = commentseq;
		this.groupno = groupno;
		this.groupseq = groupseq;
		this.titletab = titletab;
		this.commentid = commentid;
		this.content = content;
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

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public int getCommentseq() {
		return commentseq;
	}

	public void setCommentseq(int commentseq) {
		this.commentseq = commentseq;
	}

	public int getGroupno() {
		return groupno;
	}

	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}

	public int getGroupseq() {
		return groupseq;
	}

	public void setGroupseq(int groupseq) {
		this.groupseq = groupseq;
	}

	public int getTitletab() {
		return titletab;
	}

	public void setTitletab(int titletab) {
		this.titletab = titletab;
	}

	public String getCommentid() {
		return commentid;
	}

	public void setCommentid(String commentid) {
		this.commentid = commentid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	

}
