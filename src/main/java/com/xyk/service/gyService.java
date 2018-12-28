package com.xyk.service;

import com.xyk.dao.gyDao;
import com.xyk.model.gyModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class gyService {
    @Resource
    private gyDao gd;
    public List<gyModel> selbyid(String apartment_id){return gd.selbyid(apartment_id);}
    public List<gyModel> list(){return  gd.list();}
}
