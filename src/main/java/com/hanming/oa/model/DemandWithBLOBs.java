package com.hanming.oa.model;

public class DemandWithBLOBs extends Demand {
    private String descs;

    private String acceptanceStand;

	public String getDescs() {
		return descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public String getAcceptanceStand() {
		return acceptanceStand;
	}

	public void setAcceptanceStand(String acceptanceStand) {
		this.acceptanceStand = acceptanceStand;
	}
    
}