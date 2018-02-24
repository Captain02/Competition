package com.hanming.oa.model;

public class Demand {
	private Integer id;

	private Integer projectId;

	private String demandName;

	private Integer createPeopele;

	private String source;

	private String grade;

	private String stage;

	private String state;

	private Integer assignor;

	private String workTime;

	private String descs;

	private String acceptanceStand;

	private String enclosure;

	private String fileName;

	private String createTime;

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

	public String getDemandName() {
		return demandName;
	}

	public void setDemandName(String demandName) {
		this.demandName = demandName;
	}

	public Integer getCreatePeopele() {
		return createPeopele;
	}

	public void setCreatePeopele(Integer createPeopele) {
		this.createPeopele = createPeopele;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getAssignor() {
		return assignor;
	}

	public void setAssignor(Integer assignor) {
		this.assignor = assignor;
	}

	public String getWorkTime() {
		return workTime;
	}

	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}

	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public String getAcceptanceStand() {
		return acceptanceStand;
	}

	public void setAcceptanceStand(String acceptanceStand) {
		this.acceptanceStand = acceptanceStand;
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

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "Demand [id=" + id + ", projectId=" + projectId + ", demandName=" + demandName + ", createPeopele="
				+ createPeopele + ", source=" + source + ", grade=" + grade + ", stage=" + stage + ", state=" + state
				+ ", assignor=" + assignor + ", workTime=" + workTime + ", descs=" + descs + ", acceptanceStand="
				+ acceptanceStand + ", enclosure=" + enclosure + ", fileName=" + fileName + ", createTime=" + createTime
				+ "]";
	}

}