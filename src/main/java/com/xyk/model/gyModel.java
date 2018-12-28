package com.xyk.model;

public class gyModel {
    private String apartment_id;
    private int useable;
    private String location;
    private String owner;
    private String factory;

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }
    public String getApartment_id() {
        return apartment_id;
    }

    public void setApartment_id(String apartment_id) {
        this.apartment_id = apartment_id;
    }

    public int getUseable() {
        return useable;
    }

    public void setUseable(int useable) {
        this.useable = useable;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }
}
