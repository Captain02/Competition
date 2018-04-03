package com.hanming.oa.model;

import org.hibernate.validator.constraints.NotBlank;

public class Document {
	private Integer id;

	private Integer projectId;

	private String documentName;

	private String type;

	private Integer createPeople;

	private String createTime;

	private String keyword;

	private String fileName;

	private String enclosure;

	@NotBlank(message = "描述不为空")
	private String descs;

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

	public String getDocumentName() {
		return documentName;
	}

	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(Integer createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getEnclosure() {
		return enclosure;
	}

	public void setEnclosure(String enclosure) {
		this.enclosure = enclosure;
	}

	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	@Override
	public String toString() {
		return "Document [id=" + id + ", projectId=" + projectId + ", documentName=" + documentName + ", type=" + type
				+ ", createPeople=" + createPeople + ", createTime=" + createTime + ", keyword=" + keyword
				+ ", fileName=" + fileName + ", enclosure=" + enclosure + ", descs=" + descs + "]";
	}

}