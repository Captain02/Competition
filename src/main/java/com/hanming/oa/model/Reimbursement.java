package com.hanming.oa.model;

import java.sql.Date;

public class Reimbursement {
	private Integer id;

	private Float money;

	private String type;

	private String detailed;

	private Date date;

	private String processinstanceid;

	private String test;

	private String enclosure;

	private String filename;

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
		this.type = type == null ? null : type.trim();
	}

	public String getDetailed() {
		return detailed;
	}

	public void setDetailed(String detailed) {
		this.detailed = detailed == null ? null : detailed.trim();
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getProcessinstanceid() {
		return processinstanceid;
	}

	public void setProcessinstanceid(String processinstanceid) {
		this.processinstanceid = processinstanceid == null ? null : processinstanceid.trim();
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test == null ? null : test.trim();
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure == null ? null : enclosure.trim();
	}
}