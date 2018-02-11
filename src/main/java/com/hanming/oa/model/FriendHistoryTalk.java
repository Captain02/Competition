package com.hanming.oa.model;

public class FriendHistoryTalk {
    private Integer id;

    private Integer userid;

    private Integer fromid;

    private Integer toid;

    private String date;

    private String text;

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

    public Integer getFromid() {
        return fromid;
    }

    public void setFromid(Integer fromid) {
        this.fromid = fromid;
    }

    public Integer getToid() {
        return toid;
    }

    public void setToid(Integer toid) {
        this.toid = toid;
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

	public FriendHistoryTalk(Integer id, Integer userid, Integer fromid, Integer toid, String date, String text) {
		super();
		this.id = id;
		this.userid = userid;
		this.fromid = fromid;
		this.toid = toid;
		this.date = date;
		this.text = text;
	}

	public FriendHistoryTalk() {
		super();
		// TODO Auto-generated constructor stub
	}
    
}