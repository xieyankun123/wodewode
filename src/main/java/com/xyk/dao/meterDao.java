package com.xyk.dao;

import com.xyk.model.dianModel;
import com.xyk.model.gasModel;
import com.xyk.model.waterModel;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface meterDao {
    List<dianModel> selbyAUid(String user_id);
    List<gasModel> selbyGUid(String user_id);
    List<waterModel> selbyWUid(String user_id);
    List<dianModel> selbyAID(String AID_out);
    List<gasModel> selbyGID(String GID_out);
    List<waterModel> selbyWID(String WID_out);
    boolean addA(dianModel a);
    boolean addG(gasModel a);
    boolean addW(waterModel a);
    boolean updateA(@Param("value")String value, @Param("id")int id);
    boolean updateG(@Param("value")String value, @Param("id")int id);
    boolean updateW(@Param("value")String value, @Param("id")int id);
}
