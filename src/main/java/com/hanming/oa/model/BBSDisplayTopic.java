package com.hanming.oa.model;

import java.util.List;

public class BBSDisplayTopic {

	private Integer id;

	private String title;

	private String sketch;

	private List<String> labelName;

	private String date;

	private Integer like;

	private Integer collection;

	private Integer comment;

	private Integer userId;

	private String userName;

	private String userHeadFile;

	public String getSketch() {
		return sketch;
	}

	public void setSketch(String sketch) {
		this.sketch = sketch;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<String> getLabelName() {
		return labelName;
	}

	public void setLabelName(List<String> labelName) {
		this.labelName = labelName;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Integer getLike() {
		return like;
	}

	public void setLike(Integer like) {
		this.like = like;
	}

	public Integer getCollection() {
		return collection;
	}

	public void setCollection(Integer collection) {
		this.collection = collection;
	}

	public Integer getComment() {
		return comment;
	}

	public void setComment(Integer comment) {
		this.comment = comment;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserHeadFile() {
		return userHeadFile;
	}

	public void setUserHeadFile(String userHeadFile) {
		this.userHeadFile = userHeadFile;
	}

}
