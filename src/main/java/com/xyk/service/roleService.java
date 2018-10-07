package com.xyk.service;

import com.xyk.dao.roleDao;
import com.xyk.model.roleModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class roleService {
    @Resource
    private roleDao rd;
    public List<roleModel> list(){return rd.list();}
    public boolean add(roleModel a){return  rd.add(a);}
    public boolean update(roleModel a){return  rd.update(a);}
    public boolean del(String role_id){return rd.del(role_id);}
}
