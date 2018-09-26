package com.xyk.model;

import java.util.Date;

public class u_rModel {
    private String user_name;
    private String in_time;
    private String out_time;
    private String room_id;
    private int user_number;

    @Override
    public String toString() {
        return "u_rModel{" +
                "user_name='" + user_name + '\'' +
                ", in_time=" + in_time +
                ", out_time=" + out_time +
                ", room_id='" + room_id + '\'' +
                ", user_number=" + user_number +
                '}';
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getIn_time() {
        return in_time;
    }

    public void setIn_time(String in_time) {
        this.in_time = in_time;
    }

    public String getOut_time() {
        return out_time;
    }

    public void setOut_time(String out_time) {
        this.out_time = out_time;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
    }

    public int getUser_number() {
        return user_number;
    }

    public void setUser_number(int user_number) {
        this.user_number = user_number;
    }
}
