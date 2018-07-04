package com.wxm.dao;

import java.util.List;

import com.wxm.model.LolaModel;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface LolaDao {
    List<LolaModel> selectLolaByTaskId(String taskId);
}
