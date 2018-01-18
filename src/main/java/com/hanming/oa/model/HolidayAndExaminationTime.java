package com.hanming.oa.model;

import java.sql.Date;

public class HolidayAndExaminationTime {
	private Integer id;

	private String type;

	private Date startday;

	private Date endday;

	private Integer holidaydays;

	private String test;

	private String reason;

	private String enclosure;
	
	private String date;

	private String processinstanceid;

	private java.util.Date startExaminationTime;

	private java.util.Date examinationTime;

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
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
		this.type = type;
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
		this.test = test;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure;
	}

	public String getProcessinstanceid() {
		return processinstanceid;
	}

	public void setProcessinstanceid(String processinstanceid) {
		this.processinstanceid = processinstanceid;
	}

	public java.util.Date getExaminationTime() {
		return examinationTime;
	}

	public void setExaminationTime(java.util.Date examinationTime) {
		this.examinationTime = examinationTime;
	}

	public java.util.Date getStartExaminationTime() {
		return startExaminationTime;
	}

	public void setStartExaminationTime(java.util.Date startExaminationTime) {
		this.startExaminationTime = startExaminationTime;
	}

}
