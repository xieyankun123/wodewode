package com.xyk.model;

public class apdataModel {
    private int id;
    private String apparatus_id;
    private String time;
    private String value;
    private String name;
    private String factory;

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
