package com.hanming.oa.model;

public class ProjectHistory {
	private Integer id;

	private String historyType;

	private Integer typeId;

	private String operationTime;

	private Integer operationPeopleId;

	private String operationType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getHistoryType() {
		return historyType;
	}

	public void setHistoryType(String historyType) {
		this.historyType = historyType;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getOperationTime() {
		return operationTime;
	}

	public void setOperationTime(String operationTime) {
		this.operationTime = operationTime;
	}

	public Integer getOperationPeopleId() {
		return operationPeopleId;
	}

	public void setOperationPeopleId(Integer operationPeopleId) {
		this.operationPeopleId = operationPeopleId;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	
	
}