package com.wxm.service.impl;

import com.wxm.dao.DengluDao;
import com.wxm.model.DengluModel;
import com.wxm.service.IDengluService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class DengluService implements IDengluService {
    @Resource
    private DengluDao dengluDao;
    @Override
    public DengluModel login(String username,String password)
    {
        DengluModel b=dengluDao.bidui(username);
        if(b!=null&&b.getPassword().equals(password)) {
            return b;
        }
        return null;
    }
}
