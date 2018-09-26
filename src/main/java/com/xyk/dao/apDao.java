package com.xyk.dao;

import com.xyk.model.ApModel;
import org.mybatis.spring.annotation.MapperScan;
import java.util.List;
@MapperScan
public interface apDao {
    List<ApModel> selbyid(String apparatus_id);
    List<ApModel> selbyp(String user_name_on);
    List<ApModel> list();
    void adddata(ApModel a);
}
