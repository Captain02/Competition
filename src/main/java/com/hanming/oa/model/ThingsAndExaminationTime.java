package com.hanming.oa.model;

import java.sql.Date;

public class ThingsAndExaminationTime {
	private Integer id;

    private String name;

    private Integer number;

    private String date;

    private String purpose;

    private String state;

    private String details;

    private String enclosure;

    private String filename;

    private String processinstanceid;
	
	private java.util.Date startExaminationTime;

	private java.util.Date examinationTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getProcessinstanceid() {
		return processinstanceid;
	}

	public void setProcessinstanceid(String processinstanceid) {
		this.processinstanceid = processinstanceid;
	}

	public java.util.Date getStartExaminationTime() {
		return startExaminationTime;
	}

	public void setStartExaminationTime(java.util.Date startExaminationTime) {
		this.startExaminationTime = startExaminationTime;
	}

	public java.util.Date getExaminationTime() {
		return examinationTime;
	}

	public void setExaminationTime(java.util.Date examinationTime) {
		this.examinationTime = examinationTime;
	}
	
}
