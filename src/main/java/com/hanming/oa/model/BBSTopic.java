package com.hanming.oa.model;

import java.io.Serializable;

public class BBSTopic implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;

	private String title;

	private String sketch;

	private String text;

	private Integer userId;

	private String date;

	private Integer like;

	private Integer collection;

	private Integer comment;

	private String type;

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

	public String getSketch() {
		return sketch;
	}

	public void setSketch(String sketch) {
		this.sketch = sketch;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public BBSTopic(Integer id, String title, String sketch, String text, Integer userId, String date, String type) {
		super();
		this.id = id;
		this.title = title;
		this.sketch = sketch;
		this.text = text;
		this.userId = userId;
		this.date = date;
		this.type = type;
	}

	public BBSTopic() {
		super();
	}
	
}