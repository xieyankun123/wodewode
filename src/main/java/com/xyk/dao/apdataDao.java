package com.xyk.dao;

import com.xyk.model.ApModel;
import com.xyk.model.apdataModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface apdataDao {
    List<apdataModel> selbyid(String devID);
    List<apdataModel> list();
    boolean add(apdataModel a);
}
