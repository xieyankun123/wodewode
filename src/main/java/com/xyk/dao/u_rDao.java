package com.xyk.dao;

import com.xyk.model.u_rModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface u_rDao {
    List<u_rModel> selbyUtel(String user_telephone);
    List<u_rModel> selbyRid(String room_id);
    List<u_rModel> list();
    u_rModel selbyid(int id);
    boolean add(u_rModel a);
    boolean update(u_rModel a);
    boolean dele(int id);
}
