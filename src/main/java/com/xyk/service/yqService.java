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
    public boolean updateBeizhu(String beizhu,String id){return yd.updateBeizhu(beizhu,id);}
    public List<yqModel> selbyRid(String room_id){return yd.selbyRid(room_id);}
    public List<yqModel> list(){return yd.list();}
    public boolean update(yqModel yq){return yd.update(yq);}
    public boolean upbyid(String useable,String id){return yd.upbyid(useable,id);}
    public yqModel selbyid(String id){return yd.selbyid(id);}
    public boolean add(yqModel yq){return yd.add(yq);}

}
