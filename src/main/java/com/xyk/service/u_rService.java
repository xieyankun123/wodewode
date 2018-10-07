package com.xyk.service;

import com.xyk.dao.u_rDao;
import com.xyk.model.u_rModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class u_rService {
    @Resource
    private u_rDao u_r;
    public List<u_rModel> selbyUtel(String user_telephone)
    {
        return u_r.selbyUtel(user_telephone);
    }
    public List<u_rModel> selbyRid(String room_id)
    {
        return u_r.selbyRid(room_id);
    }
    public List<u_rModel> list()
    {
        return u_r.list();
    }
    public u_rModel selbyid(int id)
    {
        return u_r.selbyid(id);
    }
    public boolean add(u_rModel a)
    {
        return u_r.add(a);
    }
    public boolean update(u_rModel a)
    {
        return u_r.update(a);
    }
    public boolean dele(int id)
    {
        return u_r.dele(id);
    }
}
