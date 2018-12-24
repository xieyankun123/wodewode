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
    public List<dianModel> selbyAUid(String user_id){return md.selbyAUid(user_id);}
    public List<gasModel> selbyGUid(String user_id){return md.selbyGUid(user_id);}
    public List<waterModel> selbyWUid(String user_id){return md.selbyWUid(user_id);}
    public List<dianModel> selbyAID(String AID_out){return md.selbyAID(AID_out);}
    public List<gasModel> selbyGID(String GID_out){return md.selbyGID(GID_out);}
    public List<waterModel> selbyWID(String WID_out){return md.selbyWID(WID_out);}
    public dianModel selAID(int id){return md.selAID(id);}
    public gasModel selGID(int id){return md.selGID(id);}
    public waterModel selWID(int id){return md.selWID(id);}
    public List<dianModel> selbyAAID(String AID_out){return md.selbyAAID(AID_out);}
    public List<gasModel> selbyGGID(String GID_out){return md.selbyGGID(GID_out);}
    public List<waterModel> selbyWWID(String WID_out){return md.selbyWWID(WID_out);}
    public boolean addA(dianModel a){return md.addA(a);}
    public boolean addG(gasModel a){return md.addG(a);}
    public boolean addW(waterModel a){return md.addW(a);}
    public boolean updateA(String value,int id){return md.updateA(value,id);}
    public boolean updateG(String value,int id){return md.updateG(value,id);}
    public boolean updateW(String value,int id){return md.updateW(value,id);}
}
