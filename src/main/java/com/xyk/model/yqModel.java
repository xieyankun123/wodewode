package com.xyk.model;

public class yqModel {
    private String id;
    private String apparatus_id;
    private String sessionID;
    private String devID;
    private String beizhu;
    private String beizhu2;
    private String OEM;
    private String useable;
    private String room_id;

    public String getSessionID() {
        return sessionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }

    public String getDevID() {
        return devID;
    }

    public void setDevID(String devID) {
        this.devID = devID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBeizhu2() {
        return beizhu2;
    }

    public void setBeizhu2(String beuzhu2) {
        this.beizhu2 = beuzhu2;
    }

    public String getApparatus_id() {
        return apparatus_id;
    }

    public void setApparatus_id(String apparatus_id) {
        this.apparatus_id = apparatus_id;
    }

    public String getBeizhu() {
        return beizhu;
    }

    public void setBeizhu(String beizhu) {
        this.beizhu = beizhu;
    }

    public String getOEM() {
        return OEM;
    }

    public void setOEM(String OEM) {
        this.OEM = OEM;
    }

    public String getUseable() {
        return useable;
    }

    public void setUseable(String useable) {
        this.useable = useable;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }
}
