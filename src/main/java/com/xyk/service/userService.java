package com.xyk.service;

import com.xyk.dao.userDao;
import com.xyk.model.UserModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class userService {
    @Resource
    private userDao userdao;
    public List<UserModel> list()
    {
        return userdao.list();
    }
    public UserModel selbyid(int id)
    {
        return userdao.selbyid(id);
    }
    public List<UserModel> selbytel(String user_telephone)
    {
        return userdao.selbytel(user_telephone);
    }
    public boolean del(int id)
    {
        return userdao.del(id);
    }
    public  boolean update(UserModel userModel)
    {
        return userdao.update(userModel);
    }
    public  int add(UserModel userModel)
    {
       userdao.add(userModel);
       return 0;
    }
}
