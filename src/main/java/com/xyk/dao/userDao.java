package com.xyk.dao;

import com.xyk.model.UserModel;
import org.mybatis.spring.annotation.MapperScan;

import javax.xml.registry.infomodel.User;
import java.util.List;

@MapperScan
public interface userDao {
    List<UserModel> list();
    UserModel selbytel(String user_telephone);
    boolean del(String user_telephone);
    boolean update(UserModel userModel);
    boolean add(UserModel userModel);
}
