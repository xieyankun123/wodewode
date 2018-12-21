package com.xyk.dao;

import com.xyk.model.addByUserModel;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import java.util.List;

@MapperScan
public interface addByUserDao {
    List<addByUserModel> list();
    List<addByUserModel> selbyuser(String byuser);
    boolean add(addByUserModel a);
    boolean addweixin(@Param("weixin")String weixin, @Param("telephone")String telephone);
}
