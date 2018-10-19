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
    public UserModel selbytel(String user_telephone)
    {
        return userdao.selbytel(user_telephone);
    }
    public boolean del(String user_telephone)
    {
        return userdao.del(user_telephone);
    }
    public  boolean update(UserModel userModel)
    {
        return userdao.update(userModel);
    }
    public boolean add(UserModel userModel)
    {
       return userdao.add(userModel);
    }
}
