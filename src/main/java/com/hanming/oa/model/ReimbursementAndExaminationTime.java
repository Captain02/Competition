package com.hanming.oa.model;

public class ReimbursementAndExaminationTime {
	private Integer id;

	private Float money;

	private String type;

	private String detailed;

	private String date;

	private String processinstanceid;

	private String test;

	private String enclosure;

	private java.util.Date startExaminationTime;

	private java.util.Date examinationTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDetailed() {
		return detailed;
	}

	public void setDetailed(String detailed) {
		this.detailed = detailed;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getProcessinstanceid() {
		return processinstanceid;
	}

	public void setProcessinstanceid(String processinstanceid) {
		this.processinstanceid = processinstanceid;
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test;
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure;
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
