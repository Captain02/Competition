package com.hanming.oa.model;

public class SystemMessage {
    private Integer id;

    private Integer userid;

    private String action;

    private String text;

    private Integer topicid;

    private String state;

    private String date;


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

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Integer getTopicid() {
		return topicid;
	}

	public void setTopicid(Integer topicid) {
		this.topicid = topicid;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public SystemMessage(Integer id, Integer userid, String action, String text, Integer topicid, String state,
			String date) {
		super();
		this.id = id;
		this.userid = userid;
		this.action = action;
		this.text = text;
		this.topicid = topicid;
		this.state = state;
		this.date = date;
	}

	public SystemMessage() {
		super();
	}
    
}