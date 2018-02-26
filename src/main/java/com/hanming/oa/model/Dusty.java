package com.hanming.oa.model;

import java.util.Date;

public class Dusty {
	private Integer id;

	private Integer projectId;

	private Integer demandId;

	private String taskType;

	private Integer completPeople;

	private Integer creatPeople;

	private Integer assignor;

	private String taskName;

	private String descs;

	private String remarks;

	private String grade;

	private String workTime;

	private String state;

	private String createTime;

	private String startTime;

	private String endTime;

	private String enclosure;

	private String fileName;

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

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public Integer getCompletPeople() {
		return completPeople;
	}

	public void setCompletPeople(Integer completPeople) {
		this.completPeople = completPeople;
	}

	public Integer getCreatPeople() {
		return creatPeople;
	}

	public void setCreatPeople(Integer creatPeople) {
		this.creatPeople = creatPeople;
	}

	public Integer getAssignor() {
		return assignor;
	}

	public void setAssignor(Integer assignor) {
		this.assignor = assignor;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getWorkTime() {
		return workTime;
	}

	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
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

	@Override
	public String toString() {
		return "Dusty [id=" + id + ", projectId=" + projectId + ", demandId=" + demandId + ", taskType=" + taskType
				+ ", completPeople=" + completPeople + ", creatPeople=" + creatPeople + ", assignor=" + assignor
				+ ", taskName=" + taskName + ", descs=" + descs + ", remarks=" + remarks + ", grade=" + grade
				+ ", workTime=" + workTime + ", state=" + state + ", createTime=" + createTime + ", startTime="
				+ startTime + ", endTime=" + endTime + ", enclosure=" + enclosure + ", fileName=" + fileName + "]";
	}

}