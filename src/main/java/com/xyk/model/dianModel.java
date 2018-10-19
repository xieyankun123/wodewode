package com.xyk.model;

public class dianModel {
    private int id;
    private String AID_out;
    private String user_id;
    private String time;
    private Double value;
    private String picture;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAID_out() {
        return AID_out;
    }

    public void setAID_out(String AID_out) {
        this.AID_out = AID_out;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
}
