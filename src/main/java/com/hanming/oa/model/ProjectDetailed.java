package com.hanming.oa.model;

public class ProjectDetailed {
	private Integer id;

	private String projectName;

	private String projectAliasName;

	private String createDate;

	private String startDate;

	private String endDate;

	private String descs;
	
	private String createPeople;

	private Integer createPeopleId;

	private String projectResponsiblePeople;
	
	private Integer projectResponsiblePeopleId;

	private String productPeople;
	
	private Integer productPeopleId;

	private String testPeople;
	
	private Integer testPeopleId;

	private String releasePeople;
	
	private Integer releasePeopleId;

	private String releaseControl;

	private String state;

	public Integer getCreatePeopleId() {
		return createPeopleId;
	}

	public void setCreatePeopleId(Integer createPeopleId) {
		this.createPeopleId = createPeopleId;
	}

	public Integer getProjectResponsiblePeopleId() {
		return projectResponsiblePeopleId;
	}

	public void setProjectResponsiblePeopleId(Integer projectResponsiblePeopleId) {
		this.projectResponsiblePeopleId = projectResponsiblePeopleId;
	}

	public Integer getProductPeopleId() {
		return productPeopleId;
	}

	public void setProductPeopleId(Integer productPeopleId) {
		this.productPeopleId = productPeopleId;
	}

	public Integer getTestPeopleId() {
		return testPeopleId;
	}

	public void setTestPeopleId(Integer testPeopleId) {
		this.testPeopleId = testPeopleId;
	}

	public Integer getReleasePeopleId() {
		return releasePeopleId;
	}

	public void setReleasePeopleId(Integer releasePeopleId) {
		this.releasePeopleId = releasePeopleId;
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

	public String getProductPeople() {
		return productPeople;
	}

	public void setProductPeople(String productPeople) {
		this.productPeople = productPeople;
	}

	public String getTestPeople() {
		return testPeople;
	}

	public void setTestPeople(String testPeople) {
		this.testPeople = testPeople;
	}

	public String getReleasePeople() {
		return releasePeople;
	}

	public void setReleasePeople(String releasePeople) {
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
