package com.hanming.oa.model;

public class DepartmentUser {
    private Integer id;

    private Integer departmentid;

    private Integer userid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDepartmentid() {
        return departmentid;
    }

    public void setDepartmentid(Integer departmentid) {
        this.departmentid = departmentid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

	public DepartmentUser(Integer departmentid, Integer userid) {
		super();
		this.departmentid = departmentid;
		this.userid = userid;
	}

	public DepartmentUser() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}