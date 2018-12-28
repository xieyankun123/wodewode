package com.xyk.service;

import com.xyk.dao.managerDao;
import com.xyk.model.managerModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class managerService {
    @Resource
    private managerDao managerdao;
    // <!--根据姓名查找-->
    public managerModel selbyname(String manager_name)
    {
        return managerdao.selbyname(manager_name);
    }
    // <!--根据手机号查找-->
    public managerModel selbytel(String manager_telephone)
    {
        return managerdao.selbytel(manager_telephone);
    }
    public List<managerModel> selbyfac(String factory) {
        return managerdao.selbyfac(factory);
    }
    //<!--获取权限-->
    public String getqx(String manager_telephone)
    {
        return managerdao.getqx(manager_telephone);
    }
    //<!--列表-->
    public List<managerModel> list()
    {
        return managerdao.list();
    }
    //<!--增加信息-->
    public boolean add(managerModel a)
    {
        return managerdao.add(a);
    }
    //更改图片信息
    public boolean updatepic(managerModel a)
    {
        return managerdao.updatepic(a);
    }
    //<!-- 更新信息-->
    public boolean update(managerModel a)
    {
        return managerdao.update(a);
    }
    //<!--删除管理员-->
    public boolean del(String manager_telephone)
    {
        return managerdao.del(manager_telephone);
    }
    //批量删除
    public boolean delAll(String[] tels)
    {
        return managerdao.delAll(tels);
    }
    //登录
    public managerModel login(String manager_telephone,String password)
    {
            managerModel b=managerdao.selbytel(manager_telephone);
            if(b.getHeadpic().equals("0"))
            { return null;}
            else if(b!=null&&b.getPassword().equals(password)) {
                      return b;
                }
                else {
                return null;}
    }
}
