package com.xyk.dao;


import com.xyk.model.AddJackModel;

import com.xyk.model.yqModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface AddJackDao {
    List<AddJackModel> list();
    List<AddJackModel> selSessionId(String sessionID);
    List<AddJackModel> selDevId(String devID);
    boolean add(yqModel a);
    boolean add_1(String a);
    boolean add_2(AddJackModel b);
}
