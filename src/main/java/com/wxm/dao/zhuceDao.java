package com.wxm.dao;

import com.wxm.model.zhuceModel;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface zhuceDao {
        zhuceModel zhuce1(String username);
        int zhuce2(@Param("username")String username, @Param("password")String password);
}
