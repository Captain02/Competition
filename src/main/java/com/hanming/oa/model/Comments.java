package com.hanming.oa.model;

import java.util.List;

public class Comments {

	private Integer id;

	private Integer userId;

	private String userName;

	private String userHeadFile;

	private String date;

	private String text;

	private Integer repliesId;

	private Integer repliesUserId;

	private String repliesUserName;

	private String repliesUserHeadFile;

	private String state;

	private List<Comments> comments;

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<Comments> getComments() {
		return comments;
	}

	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserHeadFile() {
		return userHeadFile;
	}

	public void setUserHeadFile(String userHeadFile) {
		this.userHeadFile = userHeadFile;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public Integer getRepliesId() {
		return repliesId;
	}

	public void setRepliesId(Integer repliesId) {
		this.repliesId = repliesId;
	}

	public Integer getRepliesUserId() {
		return repliesUserId;
	}

	public void setRepliesUserId(Integer repliesUserId) {
		this.repliesUserId = repliesUserId;
	}

	public String getRepliesUserName() {
		return repliesUserName;
	}

	public void setRepliesUserName(String repliesUserName) {
		this.repliesUserName = repliesUserName;
	}

	public String getRepliesUserHeadFile() {
		return repliesUserHeadFile;
	}

	public void setRepliesUserHeadFile(String repliesUserHeadFile) {
		this.repliesUserHeadFile = repliesUserHeadFile;
	}

}
