package com.hanming.oa.model;

public class ProjectTeam {
    private Integer id;

    private Integer userid;

    private Integer projectid;

    private String jointime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getProjectid() {
        return projectid;
    }

    public void setProjectid(Integer projectid) {
        this.projectid = projectid;
    }

    public String getJointime() {
        return jointime;
    }

    public void setJointime(String jointime) {
        this.jointime = jointime == null ? null : jointime.trim();
    }
}