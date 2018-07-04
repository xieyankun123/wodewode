package com.wxm.dao;

import com.wxm.model.DengluModel;
import org.mybatis.spring.annotation.MapperScan;


@MapperScan
public interface DengluDao {
    DengluModel bidui(String username);
}
