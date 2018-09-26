package com.xyk.dao;

import com.xyk.model.managerModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface managerDao {
    managerModel bidui(String manager_telephone);
    // <!--根据姓名查找-->
    managerModel selbyname(String manager_name);
    // <!--根据手机号查找-->
    managerModel selbytel(String manager_telephone);
    //<!--获取权限-->
    String getqx(String manager_telephone);
    //<!--列表-->
    List<managerModel> list();
    //<!--增加信息-->
    boolean add(managerModel a);
    //<!-- 更新图片信息-->
    boolean updatepic(managerModel a);
    //<!-- 更新信息-->
    boolean update(managerModel a);
    //<!--删除管理员-->
    boolean del(String manager_telephone);
    //批量删除
    boolean delAll(String[] tels);
}
