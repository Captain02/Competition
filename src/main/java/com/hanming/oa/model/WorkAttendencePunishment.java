package com.hanming.oa.model;

public class WorkAttendencePunishment {
    private Integer id;

    private Integer workattendenceid;

    private String state;

    private String punishmenttime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getWorkattendenceid() {
		return workattendenceid;
	}

	public void setWorkattendenceid(Integer workattendenceid) {
		this.workattendenceid = workattendenceid;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPunishmenttime() {
		return punishmenttime;
	}

	public void setPunishmenttime(String punishmenttime) {
		this.punishmenttime = punishmenttime;
	}

}