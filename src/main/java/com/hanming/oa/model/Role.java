package com.hanming.oa.model;

import org.hibernate.validator.constraints.NotBlank;

public class Role {
    private Integer id;

    @NotBlank(message="部门名称不为空")
    private String name;

    private String sn;

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
        this.name = name == null ? null : name.trim();
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn == null ? null : sn.trim();
    }

    
}