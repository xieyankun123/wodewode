package com.xyk.dao;

import com.xyk.model.roleModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface roleDao {
    List<roleModel> list();
    boolean add(roleModel a);
    boolean update(roleModel a);
    boolean del(String role_id);
}
