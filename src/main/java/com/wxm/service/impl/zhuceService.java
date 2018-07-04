package com.wxm.service.impl;

import com.wxm.dao.zhuceDao;
import com.wxm.model.zhuceModel;
import com.wxm.service.IzhuceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
@Service
public class zhuceService implements IzhuceService {
    @Resource
    private zhuceDao zhucedao;
    @Override
    public zhuceModel reg(String username, String password) {
        zhuceModel z=zhucedao.zhuce1(username);
        if(z!=null)
        {
            return z;
        }
        else {
            zhucedao.zhuce2(username,password);
            return null;
        }
     }
}
