package com.xyk.model;

public class AddJackModel {
    private String apparatus_id;
    private String devID;
    private String sessionID;


    public AddJackModel(String apparatus_id, String devID) {
        this.apparatus_id=apparatus_id;
        this.devID=devID;

    }

    public AddJackModel() {

    }


    public String getApparatus_id() {
        return apparatus_id;
    }

    public void setApparatus_id(String apparatus_id) {
        this.apparatus_id = apparatus_id;
    }


    public String getDevID() {
        return devID;
    }

    public void setDevID(String devID) {
        this.devID = devID;
    }

    public String getSessionID() {
        return sessionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }
}
