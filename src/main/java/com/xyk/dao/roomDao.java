package com.xyk.dao;

import com.xyk.model.roomModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface roomDao {
   // <!--根据房间号查找-->
   List<roomModel> selbyRid(String room_id);
   // <!--根据公寓号查找-->
    List<roomModel> selbyAid(String apartment_id);
    //<!--列表空闲的房间-->
     List<roomModel> selbyR0(int useable);
    //<!--列出有用户的房间-->
    List<roomModel> selbyR1(int useable);
    //<!--列表-->
    List<roomModel> list();
    //<!--增加信息-->
    boolean add(roomModel a);
    //<!-- 更新信息-->
    boolean update(roomModel a);
    //<!--删除房间-->
    boolean del(String room_id);
}
