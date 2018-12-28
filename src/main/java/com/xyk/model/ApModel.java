package com.xyk.model;

public class ApModel {
    private String id;
    private String apparatus_id;
    private String time;
    private String user_name_on;
    private String user_name_off;
    private String factory;

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getApparatus_id() {
        return apparatus_id;
    }

    public void setApparatus_id(String apparatus_id) {
        this.apparatus_id = apparatus_id;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getUser_name_on() {
        return user_name_on;
    }

    public void setUser_name_on(String user_name_on) {
        this.user_name_on = user_name_on;
    }

    public String getUser_name_off() {
        return user_name_off;
    }

    public void setUser_name_off(String user_name_off) {
        this.user_name_off = user_name_off;
    }
}
