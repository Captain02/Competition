package com.hanming.oa.model;

public class BugDisplay {
	private Integer id;
	
	private String grade;

	private String bugTitle;

	private String state;

	private String creatPeople;
	
	private String creatTime;

	private String assginor;

	private String completpeople;
	
	private String endtime;

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBugTitle() {
		return bugTitle;
	}

	public void setBugTitle(String bugTitle) {
		this.bugTitle = bugTitle;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCreatPeople() {
		return creatPeople;
	}

	public void setCreatPeople(String creatPeople) {
		this.creatPeople = creatPeople;
	}

	public String getAssginor() {
		return assginor;
	}

	public void setAssginor(String assginor) {
		this.assginor = assginor;
	}

	public String getCompletpeople() {
		return completpeople;
	}

	public void setCompletpeople(String completpeople) {
		this.completpeople = completpeople;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

}
