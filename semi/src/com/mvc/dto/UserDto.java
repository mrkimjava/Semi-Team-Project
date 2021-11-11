package com.mvc.dto;

import java.util.Date;

public class UserDto {
	private String user_id;
	private int seq;
	private Date join_date;
	private Date leave_date;
	private String name;
	private String phone;
	private String email;
	private String passwd;
	private String nickname;
	private int age;
	private String address;
	private String u_national;
	private String gender;
	private String active;
	private int panalty;
	private String user_img;
	private String sns;

	public String getSns() {
		return sns;
	}

	public void setSns(String sns) {
		this.sns = sns;
	}

	public UserDto(String user_id, int seq, Date join_date, Date leave_date, String name, String phone, String email,
			String passwd, String nickname, int age, String address, String u_national, String gender, String active,
			int panalty, String user_img, String sns) {
		super();
		this.user_id = user_id;
		this.seq = seq;
		this.join_date = join_date;
		this.leave_date = leave_date;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.passwd = passwd;
		this.nickname = nickname;
		this.age = age;
		this.address = address;
		this.u_national = u_national;
		this.gender = gender;
		this.active = active;
		this.panalty = panalty;
		this.user_img = user_img;
		this.sns = sns;
	}

	public UserDto() {
		super();
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public Date getJoin_date() {
		return join_date;
	}

	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	public Date getLeave_date() {
		return leave_date;
	}

	public void setLeave_date(Date leave_date) {
		this.leave_date = leave_date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getU_national() {
		return u_national;
	}

	public void setU_national(String u_national) {
		this.u_national = u_national;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	public int getPanalty() {
		return panalty;
	}

	public void setPanalty(int panalty) {
		this.panalty = panalty;
	}
	
	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}
}
