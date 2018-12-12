package com.xyk.service;

import com.xyk.dao.apdataDao;
import com.xyk.model.apdataModel;
import com.xyk.model.echartsModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class apdataService {
    @Resource
    private apdataDao ad;
    public List<apdataModel> selbyid(String devID){return ad.selbyid(devID);}
    public List<echartsModel> getdv(String apparatus_id){return ad.getdv(apparatus_id);}
    public List<echartsModel> getpv(String apparatus_id){return ad.getpv(apparatus_id);}
    public List<apdataModel> list(){return ad.list();}
    public boolean add(apdataModel a){return ad.add(a);}
    public List<apdataModel> selbyidP(String devID){return ad.selbyidP(devID);}
    public List<apdataModel> listP(){return ad.listP();}
    public boolean addP(apdataModel a){return ad.addP(a);}
    public List<apdataModel> selbynameP(String name,String apparatus_id){return ad.selbynameP(name,apparatus_id);}
    public List<apdataModel> selbyname(String name,String apparatus_id){return ad.selbyname(name,apparatus_id);}
    public boolean add0(apdataModel a){return ad.add0(a);}
    public List<apdataModel> getdv0(String name,String apparatus_id){return ad.getdv0(name,apparatus_id);}
    public boolean del(){return ad.del();}
    public boolean addhour(apdataModel a){return ad.addhour(a);}
    public List<apdataModel> gethourBy2(String name,String apparatus_id){return ad.gethourBy2(name,apparatus_id);}
    public List<apdataModel> gethourBy1(String apparatus_id){return ad.gethourBy1(apparatus_id);}
   public List<apdataModel> getbyid(String apparatus_id){return ad.getbyid(apparatus_id);}
}
