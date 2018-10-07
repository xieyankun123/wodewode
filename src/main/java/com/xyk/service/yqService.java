package com.xyk.service;

import com.xyk.dao.yqDao;
import com.xyk.model.yqModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class yqService {
    @Resource
    private yqDao yd;
    public List<yqModel> selbyRid(String room_id){return yd.selbyRid(room_id);}
    public List<yqModel> list(){return yd.list();}
    public boolean update(yqModel yq){return yd.update(yq);}
    public boolean upbyid(int useable,String apparatus_id){return yd.upbyid(useable,apparatus_id);}
    public yqModel selbyid(String apparatus_id){return yd.selbyid(apparatus_id);}
}
