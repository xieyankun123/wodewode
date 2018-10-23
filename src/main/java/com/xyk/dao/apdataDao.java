package com.xyk.dao;

import com.xyk.model.ApModel;
import com.xyk.model.apdataModel;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface apdataDao {
    List<apdataModel> selbyid(String devID);
    List<apdataModel> list();
    boolean add(apdataModel a);
    List<apdataModel> selbyidP(String devID);
    List<apdataModel> listP();
    boolean addP(apdataModel a);
    List<apdataModel> selbynameP(@Param("name")String name,@Param("apparatus_id")String apparatus_id);
}
