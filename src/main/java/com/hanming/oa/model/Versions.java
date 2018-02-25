package com.hanming.oa.model;

public class Versions {
	private Integer id;

	private Integer projectId;

	private String versionName;

	private String versionTime;

	private String sourceAddress;

	private String downLoadAddress;

	private String lssuePackageAddress;

	private String lssuePackageName;

	private Integer createPeople;

	private String createPeopleName;

	private String fileName;

	private String enclosure;

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

	public String getVersionName() {
		return versionName;
	}

	public void setVersionName(String versionName) {
		this.versionName = versionName;
	}

	public String getVersionTime() {
		return versionTime;
	}

	public void setVersionTime(String versionTime) {
		this.versionTime = versionTime;
	}

	public String getSourceAddress() {
		return sourceAddress;
	}

	public void setSourceAddress(String sourceAddress) {
		this.sourceAddress = sourceAddress;
	}

	public String getDownLoadAddress() {
		return downLoadAddress;
	}

	public void setDownLoadAddress(String downLoadAddress) {
		this.downLoadAddress = downLoadAddress;
	}

	public String getLssuePackageAddress() {
		return lssuePackageAddress;
	}

	public void setLssuePackageAddress(String lssuePackageAddress) {
		this.lssuePackageAddress = lssuePackageAddress;
	}

	public String getLssuePackageName() {
		return lssuePackageName;
	}

	public void setLssuePackageName(String lssuePackageName) {
		this.lssuePackageName = lssuePackageName;
	}

	public Integer getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(Integer createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreatePeopleName() {
		return createPeopleName;
	}

	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
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
}