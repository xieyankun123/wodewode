package com.xyk.service;

import com.xyk.dao.apdataDao;
import com.xyk.model.apdataModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class apdataService {
    @Resource
    private apdataDao ad;
    public List<apdataModel> selbyid(String devID){return ad.selbyid(devID);}
    public List<apdataModel> list(){return ad.list();}
    public boolean add(apdataModel a){return ad.add(a);}
}
