package com.hanming.oa.model;

public class UserByProjectId {
	private Integer id;

	private Integer projectTeamId;

	private String name;

	private String roleName;

	private String joinTime;

	public Integer getProjectTeamId() {
		return projectTeamId;
	}

	public void setProjectTeamId(Integer projectTeamId) {
		this.projectTeamId = projectTeamId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getJoinTime() {
		return joinTime;
	}

	public void setJoinTime(String joinTime) {
		this.joinTime = joinTime;
	}

}
