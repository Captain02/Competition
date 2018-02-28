package com.hanming.oa.model;

public class ProjectHistoryDisplay {
	private Integer id;

	private String historyType;

	private String operationTime;

	private String operationPeople;

	private String operationPeopleHead;

	private String operationType;

	public String getOperationPeopleHead() {
		return operationPeopleHead;
	}

	public void setOperationPeopleHead(String operationPeopleHead) {
		this.operationPeopleHead = operationPeopleHead;
	}

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

	public String getOperationTime() {
		return operationTime;
	}

	public void setOperationTime(String operationTime) {
		this.operationTime = operationTime;
	}

	public String getOperationPeople() {
		return operationPeople;
	}

	public void setOperationPeople(String operationPeople) {
		this.operationPeople = operationPeople;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

}
