package com.hanming.oa.model;

public class MyImage {
	private Integer id;

	private Integer userId;

	private String imagename;

	private Integer topicId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getuserId() {
		return userId;
	}

	public void setuserId(Integer userId) {
		this.userId = userId;
	}

	public String getImagename() {
		return imagename;
	}

	public void setImagename(String imagename) {
		this.imagename = imagename;
	}

	public Integer gettopicId() {
		return topicId;
	}

	public void settopicId(Integer topicId) {
		this.topicId = topicId;
	}

	public MyImage() {
		super();
	}

	public MyImage(Integer id, Integer userId, String imagename, Integer topicId) {
		super();
		this.id = id;
		this.userId = userId;
		this.imagename = imagename;
		this.topicId = topicId;
	}

}