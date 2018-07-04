package com.wxm.dao;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface TransactionDao {

    int plus(@Param("to") String to, @Param("money") String money);
    int sub(@Param("from") String from, @Param("money") String money);
}

