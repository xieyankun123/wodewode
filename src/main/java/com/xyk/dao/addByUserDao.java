package com.xyk.dao;

import com.xyk.model.addByUserModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface addByUserDao {
    List<addByUserModel> list();
    List<addByUserModel> selbyuser(String byuser);
    boolean add(addByUserModel a);
}
