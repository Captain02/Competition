package com.hanming.oa.model;

import java.sql.Date;

public class Holiday {
	private Integer id;

	private String type;

	private Date startday;

	private Date endday;

	private Integer holidaydays;

	private String test;

	private String reason;

	private String enclosure;

	private String processinstanceid;

	private String filename;

	private String date;

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type == null ? null : type.trim();
	}

	public Date getStartday() {
		return startday;
	}

	public void setStartday(Date startday) {
		this.startday = startday;
	}

	public Date getEndday() {
		return endday;
	}

	public void setEndday(Date endday) {
		this.endday = endday;
	}

	public Integer getHolidaydays() {
		return holidaydays;
	}

	public void setHolidaydays(Integer holidaydays) {
		this.holidaydays = holidaydays;
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test == null ? null : test.trim();
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason == null ? null : reason.trim();
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure == null ? null : enclosure.trim();
	}

	public String getProcessinstanceid() {
		return processinstanceid;
	}

	public void setProcessinstanceid(String string) {
		this.processinstanceid = string;
	}
}