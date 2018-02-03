package com.hanming.oa.model;

public class WorkAttendenceByMonthStatistics {
	private Integer countNum;
	
	private Integer countDays;
	
	private Integer normal;
	
	private Integer late;
	
	private Integer leave;
	
	private Integer overTime;
	
	private String absenteeism;
	
	private String sumOverTime;
	
	public String getSumOverTime() {
		return sumOverTime;
	}

	public void setSumOverTime(String sumOverTime) {
		this.sumOverTime = sumOverTime;
	}

	public Integer getCountDays() {
		return countDays;
	}

	public void setCountDays(Integer countDays) {
		this.countDays = countDays;
	}

	public Integer getCountNum() {
		return countNum;
	}

	public void setCountNum(Integer countNum) {
		this.countNum = countNum;
	}

	public Integer getNormal() {
		return normal;
	}

	public void setNormal(Integer normal) {
		this.normal = normal;
	}

	public Integer getLate() {
		return late;
	}

	public void setLate(Integer late) {
		this.late = late;
	}

	public Integer getLeave() {
		return leave;
	}

	public void setLeave(Integer leave) {
		this.leave = leave;
	}

	public Integer getOverTime() {
		return overTime;
	}

	public void setOverTime(Integer overTime) {
		this.overTime = overTime;
	}

	public String getAbsenteeism() {
		return absenteeism;
	}

	public void setAbsenteeism(String absenteeism) {
		this.absenteeism = absenteeism;
	}
	
}
