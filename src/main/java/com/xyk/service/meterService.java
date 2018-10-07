package com.xyk.service;

import com.xyk.dao.meterDao;
import com.xyk.model.dianModel;
import com.xyk.model.gasModel;
import com.xyk.model.waterModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class meterService {
    @Resource
    private meterDao md;
    public List<dianModel> selbyAUid(int user_id){return md.selbyAUid(user_id);}
    public List<gasModel> selbyGUid(int user_id){return md.selbyGUid(user_id);}
    public List<waterModel> selbyWUid(int user_id){return md.selbyWUid(user_id);}
    public List<dianModel> selbyAID(String AID_out){return md.selbyAID(AID_out);}
    public List<gasModel> selbyGID(String GID_out){return md.selbyGID(GID_out);}
    public List<waterModel> selbyWID(String WID_out){return md.selbyWID(WID_out);}
    public boolean addA(dianModel a){return md.addA(a);}
    public boolean addG(gasModel a){return md.addG(a);}
    public boolean addW(waterModel a){return md.addW(a);}
    public boolean updateA(dianModel a){return md.updateA(a);}
    public boolean updateG(gasModel a){return md.updateG(a);}
    public boolean updateW(waterModel a){return md.updateW(a);}
}
