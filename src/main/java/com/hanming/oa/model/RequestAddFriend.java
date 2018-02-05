package com.hanming.oa.model;

public class RequestAddFriend {
	private Integer id;

	private Integer fromid;

	private Integer tofriendid;

	private String data;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFromid() {
		return fromid;
	}

	public void setFromid(Integer fromid) {
		this.fromid = fromid;
	}

	public Integer getTofriendid() {
		return tofriendid;
	}

	public void setTofriendid(Integer tofriendid) {
		this.tofriendid = tofriendid;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public RequestAddFriend(Integer id, Integer fromid, Integer tofriendid, String data) {
		super();
		this.id = id;
		this.fromid = fromid;
		this.tofriendid = tofriendid;
		this.data = data;
	}

	public RequestAddFriend() {
		super();
		// TODO Auto-generated constructor stub
	}

}