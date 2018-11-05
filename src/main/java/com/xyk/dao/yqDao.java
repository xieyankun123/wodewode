package com.xyk.dao;

import com.xyk.model.yqModel;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface yqDao {
    boolean updateBeizhu(@Param("beizhu")String beizhu,@Param("id")String id);
    List<yqModel> selbyRid(String room_id);
    List<yqModel> list();
    boolean update(yqModel yq);
    boolean upbyid(@Param("useable")String useable,@Param("id")String id);
    yqModel selbyid(String id);
}
