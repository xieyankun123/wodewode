package com.xyk.service;

import com.xyk.dao.apDao;
import com.xyk.model.ApModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class apService{
    @Resource
    private apDao apdao;
    public List<ApModel> selbyid(String apparatus_id)
    {
        return apdao.selbyid(apparatus_id);
    }
   public List<ApModel> selbyp(String user_name_on)
   {
       return apdao.selbyp(user_name_on);
   }
   public List<ApModel> list()
    {
        return apdao.list();
    }
    public int add(ApModel apModel)
    {
        apdao.adddata(apModel);
        return 0;
    }
}
