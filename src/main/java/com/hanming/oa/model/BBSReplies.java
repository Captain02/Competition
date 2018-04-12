package com.hanming.oa.model;


public class BBSReplies {
	private Integer id;

	private Integer userid;

	private Integer repliseuserid;

	private Integer topicid;

	private Integer repliesid;

	private String date;

	private String text;

	private String state;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public Integer getRepliseuserid() {
		return repliseuserid;
	}

	public void setRepliseuserid(Integer repliseuserid) {
		this.repliseuserid = repliseuserid;
	}

	public Integer getTopicid() {
		return topicid;
	}

	public void setTopicid(Integer topicid) {
		this.topicid = topicid;
	}

	public Integer getRepliesid() {
		return repliesid;
	}

	public void setRepliesid(Integer repliesid) {
		this.repliesid = repliesid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
}