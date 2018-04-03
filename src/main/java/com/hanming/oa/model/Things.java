package com.hanming.oa.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

public class Things {
    private Integer id;

    @NotBlank(message = "物品名称不为空")
    private String name;

    @NotNull(message = "物品数量不为空")
    private Integer number;

    private String date;

    @NotBlank(message = "物品用途不为空")
    private String purpose;

    private String state;

    @NotBlank(message = "物品明细不为空")
    private String details;

    private String enclosure;

    private String filename;

    private String processinstanceid;

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

}