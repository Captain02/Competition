package com.hanming.oa.model;

import java.io.Serializable;

public class Project implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;

	private String projectName;

	private String projectAliasName;

	private String createDate;

	private String startDate;

	private String endDate;

	private String descs;

	private Integer createPeople;

	private Integer projectResponsiblePeople;

	private Integer productPeople;

	private Integer testPeople;

	private Integer releasePeople;

	private String releaseControl;

	private String state;

	@Override
	public String toString() {
		return "Project [id=" + id + ", projectName=" + projectName + ", projectAliasName=" + projectAliasName
				+ ", createDate=" + createDate + ", startDate=" + startDate + ", endDate=" + endDate + ", descs="
				+ descs + ", createPeople=" + createPeople + ", projectResponsiblePeople=" + projectResponsiblePeople
				+ ", productPeople=" + productPeople + ", testPeople=" + testPeople + ", releasePeople=" + releasePeople
				+ ", releaseControl=" + releaseControl + ", state=" + state + "]";
	}

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

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public Integer getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(Integer createPeople) {
		this.createPeople = createPeople;
	}

	public Integer getProjectResponsiblePeople() {
		return projectResponsiblePeople;
	}

	public void setProjectResponsiblePeople(Integer projectResponsiblePeople) {
		this.projectResponsiblePeople = projectResponsiblePeople;
	}

	public Integer getProductPeople() {
		return productPeople;
	}

	public void setProductPeople(Integer productPeople) {
		this.productPeople = productPeople;
	}

	public Integer getTestPeople() {
		return testPeople;
	}

	public void setTestPeople(Integer testPeople) {
		this.testPeople = testPeople;
	}

	public Integer getReleasePeople() {
		return releasePeople;
	}

	public void setReleasePeople(Integer releasePeople) {
		this.releasePeople = releasePeople;
	}

	public String getReleaseControl() {
		return releaseControl;
	}

	public void setReleaseControl(String releaseControl) {
		this.releaseControl = releaseControl;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}