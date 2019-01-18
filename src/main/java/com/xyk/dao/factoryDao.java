package com.xyk.dao;

import com.xyk.model.factory;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;
@MapperScan
public interface factoryDao {
    List<factory> list();
    void add(factory factory);
    void update(factory factory);
}
