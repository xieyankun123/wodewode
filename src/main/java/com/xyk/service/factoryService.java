package com.xyk.service;

import com.xyk.dao.factoryDao;
import com.xyk.model.factory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class factoryService {
    @Resource
    private factoryDao fd;
    public List<factory> list()
    {
        return fd.list();
    }
    public void add(factory factory){fd.add(factory);}
    public void update(factory factory){fd.update(factory);}
}
