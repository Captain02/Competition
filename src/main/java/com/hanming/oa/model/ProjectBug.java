package com.hanming.oa.model;

import org.hibernate.validator.constraints.NotBlank;

public class ProjectBug {
	private Integer id;

	private Integer projectId;

	private Integer demandId;

	private Integer projectTaskId;

	private String bugTitle;

	private String state;

	@NotBlank(message = "描述不为空")
	private String descs;

	private String grade;

	private String operatingSystem;

	private String browser;

	private String enclosure;

	private String fileName;

	private Integer assginor;

	private Integer creatPeople;

	private String createTime;

	private String endTime;

	private Integer completPeople;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getDemandId() {
		return demandId;
	}

	public void setDemandId(Integer demandId) {
		this.demandId = demandId;
	}

	public Integer getProjectTaskId() {
		return projectTaskId;
	}

	public void setProjectTaskId(Integer projectTaskId) {
		this.projectTaskId = projectTaskId;
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

	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getOperatingSystem() {
		return operatingSystem;
	}

	public void setOperatingSystem(String operatingSystem) {
		this.operatingSystem = operatingSystem;
	}

	public String getBrowser() {
		return browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getAssginor() {
		return assginor;
	}

	public void setAssginor(Integer assginor) {
		this.assginor = assginor;
	}

	public Integer getCreatPeople() {
		return creatPeople;
	}

	public void setCreatPeople(Integer creatPeople) {
		this.creatPeople = creatPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getCompletPeople() {
		return completPeople;
	}

	public void setCompletPeople(Integer completPeople) {
		this.completPeople = completPeople;
	}

}