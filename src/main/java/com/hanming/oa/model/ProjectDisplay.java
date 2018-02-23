package com.hanming.oa.model;

public class ProjectDisplay {
	private Integer id;

	private String projectName;

	private String projectAliasName;

	private String createPeople;

	private String projectResponsiblePeople;

	private String endDate;

	private String state;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectAliasName() {
		return projectAliasName;
	}

	public void setProjectAliasName(String projectAliasName) {
		this.projectAliasName = projectAliasName;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getProjectResponsiblePeople() {
		return projectResponsiblePeople;
	}

	public void setProjectResponsiblePeople(String projectResponsiblePeople) {
		this.projectResponsiblePeople = projectResponsiblePeople;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}
