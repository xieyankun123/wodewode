package com.xyk.dao;

import com.xyk.model.yqModel;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface yqDao {
    List<yqModel> selbyRid(String room_id);
    List<yqModel> list();
    boolean update(yqModel yq);
    boolean upbyid(@Param("useable")int useable,@Param("apparatus_id")String apparatus_id);
    yqModel selbyid(String apparatus_id);
}
