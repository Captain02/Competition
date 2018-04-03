package com.hanming.oa.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

public class Holiday {
	private Integer id;

	@NotBlank(message = "类型不为空")
	private String type;

	private String date;

	@NotBlank(message = "开始时间不为空")
	private String startday;

	@NotBlank(message = "结束时间不为空")
	private String endday;

	@NotNull(message = "请假天数")
	private Integer holidaydays;

	private String test;

	@NotBlank(message = "描述不为空")
	private String reason;

	private String enclosure;

	private String processinstanceid;

	private String filename;

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

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getStartday() {
		return startday;
	}

	public void setStartday(String startday) {
		this.startday = startday;
	}

	public String getEndday() {
		return endday;
	}

	public void setEndday(String endday) {
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

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
}