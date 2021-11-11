package com.mvc.dto;

import java.util.Date;

public class AskConnect {
	private int ask_seq;
	private String rec_id;
	private String sen_id;
	private String comment_ask;
	private String permit;
	private Date ask_date;
	private String user_img;
	private String user_name;

	public AskConnect() {
		super();
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public AskConnect(int ask_seq, String rec_id, String sen_id, String comment_ask, String permit, Date ask_date,
			String user_img, String user_name) {
		super();
		this.ask_seq = ask_seq;
		this.rec_id = rec_id;
		this.sen_id = sen_id;
		this.comment_ask = comment_ask;
		this.permit = permit;
		this.ask_date = ask_date;
		this.user_img = user_img;
		this.user_name = user_name;
	}

	public AskConnect(String sen_id, String comment_ask, Date ask_date, String user_img, String user_name) {
		this.sen_id = sen_id;
		this.comment_ask = comment_ask;
		this.ask_date = ask_date;
		this.user_img = user_img;
		this.user_name = user_name;
	}

	public int getAsk_seq() {
		return ask_seq;
	}

	public void setAsk_seq(int ask_seq) {
		this.ask_seq = ask_seq;
	}

	public String getRec_id() {
		return rec_id;
	}

	public void setRec_id(String rec_id) {
		this.rec_id = rec_id;
	}

	public String getSen_id() {
		return sen_id;
	}

	public void setSen_id(String sen_id) {
		this.sen_id = sen_id;
	}

	public String getComment_ask() {
		return comment_ask;
	}

	public void setComment_ask(String comment_ask) {
		this.comment_ask = comment_ask;
	}

	public String getPermit() {
		return permit;
	}

	public void setPermit(String permit) {
		this.permit = permit;
	}

	public Date getAsk_date() {
		return ask_date;
	}

	public void setAsk_date(Date ask_date) {
		this.ask_date = ask_date;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

}
