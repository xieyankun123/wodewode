package com.xyk.service;

import com.xyk.dao.AddJackDao;
import com.xyk.model.AddJackModel;
import com.xyk.model.yqModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AddJackService {
    @Resource
    private AddJackDao ab;
    public List<AddJackModel> list(){return ab.list();}
    public List<AddJackModel> selSessionId(String sessionID){return ab.selSessionId(sessionID);}
    public List<AddJackModel> selDevId(String devID) {return ab.selDevId(devID);}
    public boolean add(yqModel a){return ab.add(a);}
    public boolean add_1(String a){return ab.add_1(a); }
    public boolean add_2(AddJackModel b){return ab.add_2(b);}
}
