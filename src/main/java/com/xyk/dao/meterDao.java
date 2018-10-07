package com.xyk.dao;

import com.xyk.model.dianModel;
import com.xyk.model.gasModel;
import com.xyk.model.waterModel;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface meterDao {
    List<dianModel> selbyAUid(int user_id);
    List<gasModel> selbyGUid(int user_id);
    List<waterModel> selbyWUid(int user_id);
    List<dianModel> selbyAID(String AID_out);
    List<gasModel> selbyGID(String GID_out);
    List<waterModel> selbyWID(String WID_out);
    boolean addA(dianModel a);
    boolean addG(gasModel a);
    boolean addW(waterModel a);
}
