package com.xyk.model;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.metadata.BaseRowModel;

public class UserModel extends BaseRowModel {
    @ExcelProperty(value = "姓名",index = 0)
    private String user_name;
    @ExcelProperty(value = "手机号",index = 1)
    private String user_telephone;
    @ExcelProperty(value = "身份证号",index = 2)
    private String user_IDcard;
    @ExcelProperty(value = "地址",index = 3)
    private String user_address;
    @ExcelProperty(value = "性别",index = 4)
    private String user_sex;
    @ExcelProperty(value = "爱好",index = 5)
    private String user_hobby;
    @ExcelProperty(value = "状态",index = 6)
    private String user_state;
    @ExcelProperty(value = "邮箱",index = 7)
    private String user_email;
    @ExcelProperty(value = "微信",index = 8)
    private String user_weixin;
    @ExcelProperty(value = "公司",index = 9)
    private String factory;

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getUser_weixin() {
        return user_weixin;
    }

    public void setUser_weixin(String user_weixin) {
        this.user_weixin = user_weixin;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_telephone() {
        return user_telephone;
    }

    public void setUser_telephone(String user_telephone) {
        this.user_telephone = user_telephone;
    }

    public String getUser_IDcard() {
        return user_IDcard;
    }

    public void setUser_IDcard(String user_IDcard) {
        this.user_IDcard = user_IDcard;
    }

    public String getUser_address() {
        return user_address;
    }

    public void setUser_address(String user_address) {
        this.user_address = user_address;
    }

    public String getUser_sex() {
        return user_sex;
    }

    public void setUser_sex(String user_sex) {
        this.user_sex = user_sex;
    }

    public String getUser_hobby() {
        return user_hobby;
    }

    public void setUser_hobby(String user_hobby) {
        this.user_hobby = user_hobby;
    }

    public String getUser_state() {
        return user_state;
    }

    public void setUser_state(String user_state) {
        this.user_state = user_state;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }
}
