package com.xyk.model;

public class roomModel {
    private String room_id;
    private int useable;
    private String apartment_id;
    private String room_loc;
    private String room_str;
    private String xianzuke;
    private String num;
    private String own;
    private String factory;

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }
    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getOwn() {
        return own;
    }

    public void setOwn(String own) {
        this.own = own;
    }

    public String getXianzuke() {
        return xianzuke;
    }

    public void setXianzuke(String xianzuke) {
        this.xianzuke = xianzuke;
    }

    public String getApartment_id() {
        return apartment_id;
    }

    public void setApartment_id(String apartment_id) {
        this.apartment_id = apartment_id;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    public int getUseable() {
        return useable;
    }

    public void setUseable(int useable) {
        this.useable = useable;
    }

    public String getRoom_loc() {
        return room_loc;
    }

    public void setRoom_loc(String room_loc) {
        this.room_loc = room_loc;
    }

    public String getRoom_str() {
        return room_str;
    }

    public void setRoom_str(String room_str) {
        this.room_str = room_str;
    }
}
