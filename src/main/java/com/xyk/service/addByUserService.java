package com.xyk.service;

import com.xyk.dao.addByUserDao;
import com.xyk.model.addByUserModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class addByUserService {
    @Resource
    private addByUserDao ab;
    public List<addByUserModel> list(){return ab.list();}
    public List<addByUserModel> selbyuser(String byuser){return ab.selbyuser(byuser);}
    public boolean add(addByUserModel a){return ab.add(a);}
    public boolean addweixin(String weixin,String telephone)
    {
        return ab.addweixin(weixin,telephone);
    }
}
