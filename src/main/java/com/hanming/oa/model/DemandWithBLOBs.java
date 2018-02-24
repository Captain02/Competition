package com.hanming.oa.model;

public class DemandWithBLOBs extends Demand {
    private String descs;

    private String acceptancestand;

    public String getDescs() {
        return descs;
    }

    public void setDescs(String descs) {
        this.descs = descs == null ? null : descs.trim();
    }

    public String getAcceptancestand() {
        return acceptancestand;
    }

    public void setAcceptancestand(String acceptancestand) {
        this.acceptancestand = acceptancestand == null ? null : acceptancestand.trim();
    }
}