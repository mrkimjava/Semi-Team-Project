package com.mvc.dto;

public class HeartDto {
	private String userid;
	private String place_id;
	private String thumbnail;
	private String place_name;
	private String latitude;
	private String longtitude;
	private String place_address;
	private String nation;
	private String city;
	
	public HeartDto() {}

	public HeartDto(String userid, String place_id, String thumbnail, String place_name, String latitude,
			String longtitude, String place_address, String nation, String city) {
		super();
		this.userid = userid;
		this.place_id = place_id;
		this.thumbnail = thumbnail;
		this.place_name = place_name;
		this.latitude = latitude;
		this.longtitude = longtitude;
		this.place_address = place_address;
		this.nation = nation;
		this.city = city;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPlace_id() {
		return place_id;
	}

	public void setPlace_id(String place_id) {
		this.place_id = place_id;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(String longtitude) {
		this.longtitude = longtitude;
	}

	public String getPlace_address() {
		return place_address;
	}

	public void setPlace_address(String place_address) {
		this.place_address = place_address;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	
}
