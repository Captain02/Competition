package com.hanming.oa.model;

public class Event {
	private Integer id;

	private String title;

	private String start;

	private String end;

	private String color;

	private String allDay;

	private String className;

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

	public String getStartTime() {
		return start;
	}

	public void setStartTime(String start) {
		this.start = start;
	}

	public String getEndTime() {
		return end;
	}

	public void setEndTime(String end) {
		this.end = end;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getAllDay() {
		return allDay;
	}

	public void setAllDay(String allDay) {
		this.allDay = allDay;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

}
