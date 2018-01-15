package com.hanming.oa.model;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotBlank;

public class Resource implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;

    @NotBlank(message="名称不为空")
    private String name;
    
    @NotBlank(message="栏目不为空")
    private String column;

    @NotBlank(message="描述不为空")
    private String permission;

    @NotBlank(message="拦截链接不为空")
    private String url;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission == null ? null : permission.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
}