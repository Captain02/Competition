package com.hanming.oa.reportForm;

public class roleReprotForm {

	public Long value;

	public String name;

	public Long getValue() {
		return value;
	}

	public void setValue(Long value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public roleReprotForm(Long value, String name) {
		super();
		this.value = value;
		this.name = name;
	}

	public roleReprotForm() {
		super();
		// TODO Auto-generated constructor stub
	}

}
