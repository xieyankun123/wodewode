package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.dianModel;
import com.xyk.model.gasModel;
import com.xyk.model.waterModel;
import com.xyk.service.meterService;
import com.xyk.service.u_rService;
import com.xyk.service.userService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/meter")
public class meterController {
    @Resource
    private meterService ms;
    @Resource
    private userService us;
    @Resource
    private u_rService ur;
    @RequestMapping("/getbyUid")
    public void get(HttpServletResponse response,int id)
    {
        JSONObject result=new JSONObject();
        UserModel user=us.selbyid(id);
        List<dianModel> a=ms.selbyAUid(id);
        List<gasModel> b=ms.selbyGUid(id);
        List<waterModel> c=ms.selbyWUid(id);
        String atime=a.get(a.size()-1).getTime();
        String btime=b.get(b.size()-1).getTime();
        String ctime=c.get(c.size()-1).getTime();
        System.out.println(atime+btime+ctime);
        result.put("atime",atime);
        result.put("gtime",btime);
        result.put("wtime",ctime);
        System.out.println(a.get(a.size()-1).getValue());
        BigDecimal aa1=new BigDecimal(a.get(a.size()-1).getValue());
        BigDecimal aa2=new BigDecimal(a.get(0).getValue());
        Double aa=aa1.subtract(aa2).doubleValue();
      // BigDecimal bb1=new BigDecimal(b.get(b.size()-1).getValue());
       // BigDecimal bb2=new BigDecimal(b.get(0).getValue());
        //Double bb=bb1.subtract(bb2).doubleValue();
//        BigDecimal cc1=new BigDecimal(c.get(c.size()-1).getValue());
//        BigDecimal cc2=new BigDecimal(c.get(0).getValue());
//        Double cc=cc1.subtract(cc2).doubleValue();
        System.out.println(aa);
        result.put("avalue",aa);
        //result.put("gvalue",bb);
//        result.put("wvalue",cc);
        result.put("user",user);
        result.put("dian",a);
        result.put("gas",b);
        result.put("water",c);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
