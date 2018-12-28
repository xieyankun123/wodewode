package com.xyk.service;

import com.xyk.dao.roomDao;
import com.xyk.model.roomModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class roomService {
    @Resource
    private roomDao roomdao;
    // <!--根据房间号查找-->
    public List<roomModel> selbyRid(String room_id)
    {
        return roomdao.selbyRid(room_id);
    }
    // <!--根据公寓号查找-->
    public List<roomModel> selbyAid(String apartment_id)
    {
        return roomdao.selbyAid(apartment_id);
    }
    //<!--列表空闲的房间-->
    public List<roomModel> selbyR0(int useable)
    {
        return roomdao.selbyR0(useable);
    }
    //<!--列出有用户的房间-->
    public List<roomModel> selbyR1(int useable)
    {
        return roomdao.selbyR1(useable);
    }
    //<!--列表-->
    public List<roomModel> list()
    {
        return roomdao.list();
    }
    //<!--增加信息-->
    public boolean add(roomModel a)
    {
        return roomdao.add(a);
    }
    //<!-- 更新信息-->
    public boolean update(roomModel a)
    {
        return roomdao.update(a);
    }
    //<!--删除房间-->
    public boolean del(String room_id)
    {
        return roomdao.del(room_id);
    }
}
