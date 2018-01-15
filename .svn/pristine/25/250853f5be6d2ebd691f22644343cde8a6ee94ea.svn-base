package com.hanming.oa.model;

import org.hibernate.validator.constraints.NotBlank;

public class Department {
    private Integer id;

    @NotBlank(message="部门名不能为空")
    private String name;
    
    private String description;
    
    @NotBlank(message="地址不能为空")
    private String address;
    
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
    public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}