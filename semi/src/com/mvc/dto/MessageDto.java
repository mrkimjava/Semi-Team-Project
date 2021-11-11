package com.mvc.dto;

import java.util.Date;

public class MessageDto {
	private int m_number;
	private String chat_serial;
	private String rec_id;
	private String sen_id;
	private String message;
	private Date m_time;
	private String sender_img;
	private String user_name;

	public MessageDto() {
		super();
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public MessageDto(int m_number, String chat_serial, String rec_id, String sen_id, String message, Date m_time,
			String sender_img, String user_name) {
		super();
		this.m_number = m_number;
		this.chat_serial = chat_serial;
		this.rec_id = rec_id;
		this.sen_id = sen_id;
		this.message = message;
		this.m_time = m_time;
		this.sender_img = sender_img;
		this.user_name = user_name;
	}

	public String getChat_serial() {
		return chat_serial;
	}

	public void setChat_serial(String chat_serial) {
		this.chat_serial = chat_serial;
	}

	public int getM_number() {
		return m_number;
	}

	public void setM_number(int m_number) {
		this.m_number = m_number;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getM_time() {
		return m_time;
	}

	public void setM_time(Date m_time) {
		this.m_time = m_time;
	}

	public String getSender_img() {
		return sender_img;
	}

	public void setSender_img(String sender_img) {
		this.sender_img = sender_img;
	}

}
