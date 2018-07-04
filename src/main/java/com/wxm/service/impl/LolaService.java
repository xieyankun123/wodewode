package com.wxm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.wxm.dao.LolaDao;
import com.wxm.model.LolaModel;
import com.wxm.service.ILolaService;
import org.springframework.stereotype.Service;

@Service
public class LolaService implements ILolaService {

    @Resource
    private LolaDao lolaDao;

    @Override
    public List<LolaModel> getLolaByTaskId(String taskId) {
        return lolaDao.selectLolaByTaskId(taskId);
    }
    
}
