package com.hanming.oa.model;

public class Message {
	// 发送者
	private Integer fromId;
	// 发送者名称
	private String fromName;
	// 接收者
	private Integer toId;
	// 发送的文本
	private String text;
	// 发送日期
	private String date;

	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getFromId() {
		return fromId;
	}

	public void setFromId(Integer fromId) {
		this.fromId = fromId;
	}

	public String getFromName() {
		return fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public Integer getToId() {
		return toId;
	}

	public void setToId(Integer toId) {
		this.toId = toId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Message(Integer fromId, String fromName, Integer toId, String text, String date, String type) {
		super();
		this.fromId = fromId;
		this.fromName = fromName;
		this.toId = toId;
		this.text = text;
		this.date = date;
		this.type = type;
	}

	public Message() {
		super();
	}

}