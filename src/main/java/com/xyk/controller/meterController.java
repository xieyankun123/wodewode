package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.dianModel;
import com.xyk.model.gasModel;
import com.xyk.model.waterModel;
import com.xyk.service.meterService;
import com.xyk.service.roomService;
import com.xyk.service.u_rService;
import com.xyk.service.userService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import com.xyk.util.DateUtil;
//测试git

@Controller
@RequestMapping("/meter")
public class meterController {
    @Resource
    private meterService ms;
    @Resource
    private userService us;
    @Resource
    private u_rService ur;
    @Resource
    private roomService rs;
    @RequestMapping("/getbyUid")
    public void getbyUid(HttpServletResponse response,int id)
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
      BigDecimal bb1=new BigDecimal(b.get(b.size()-1).getValue());
      BigDecimal bb2=new BigDecimal(b.get(0).getValue());
        Double bb=bb1.subtract(bb2).doubleValue();
       BigDecimal cc1=new BigDecimal(c.get(c.size()-1).getValue());
       BigDecimal cc2=new BigDecimal(c.get(0).getValue());
       Double cc=cc1.subtract(cc2).doubleValue();
        System.out.println(aa);
        System.out.println(bb);
        result.put("avalue",aa);
       result.put("gvalue",bb);
       result.put("wvalue",cc);
        result.put("user",user);
        result.put("dian",a);
        result.put("gas",b);
        result.put("water",c);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/getbyRid")
    public void getbyRid(HttpServletResponse response, HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        String room_id=request.getParameter("room_id");
        String apid=rs.selbyRid(room_id).getApartment_id();
        List<dianModel> a=ms.selbyAID(apid);
        List<gasModel> b=ms.selbyGID(apid);
        List<waterModel> c=ms.selbyWID(apid);
        BigDecimal aa1=new BigDecimal(a.get(a.size()-1).getValue());
        BigDecimal aa2=new BigDecimal(a.get(0).getValue());
        Double aa=aa1.subtract(aa2).doubleValue();
        BigDecimal bb1=new BigDecimal(b.get(b.size()-1).getValue());
        BigDecimal bb2=new BigDecimal(b.get(0).getValue());
        Double bb=bb1.subtract(bb2).doubleValue();
        BigDecimal cc1=new BigDecimal(c.get(c.size()-1).getValue());
        BigDecimal cc2=new BigDecimal(c.get(0).getValue());
        Double cc=cc1.subtract(cc2).doubleValue();
        System.out.println(aa);
        System.out.println(bb);
        result.put("avalue",aa);
        result.put("gvalue",bb);
        result.put("wvalue",cc);
        result.put("dian",a);
        result.put("gas",b);
        result.put("water",c);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/insert")
    public void insert(HttpServletResponse response,HttpServletRequest request,int id)
    {
        JSONObject result=new JSONObject();
        String meter=request.getParameter("meter");
        String pic=request.getParameter("picture");
       String room_id=ur.selbyUtel(us.selbyid(id).getUser_telephone()).get(ur.selbyUtel(us.selbyid(id).getUser_telephone()).size()-1).getRoom_id();
        String apid=rs.selbyRid(room_id).getApartment_id();
        DateUtil dat=new DateUtil();
        String date=dat.getDay();
        System.out.println(date);
        if(meter.equals("water"))
        {
            waterModel a=new waterModel();
            a.setPicture(pic);
            a.setUser_id(id);
            a.setWID_out(apid);
            a.setTime(date);
            ms.addW(a);
            result.put("msg","水表的信息插入成功");
        }
        else if(meter.equals("gas"))
        {
            gasModel a=new gasModel();
            a.setPicture(pic);
            a.setUser_id(id);
            a.setGID_out(apid);
            a.setTime(date);
            ms.addG(a);
            result.put("msg","气表的信息插入成功");
        }
        else if(meter.equals("dian"))
        {
            dianModel a=new dianModel();
            a.setPicture(pic);
            a.setUser_id(id);
            a.setAID_out(apid);
            a.setTime(date);
            ms.addA(a);
            result.put("msg","电表的信息插入成功");
        }
        else{
            result.put("msg","错误错误");
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("updateA")
    public void updateA(dianModel dian,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        ms.updateA(dian);
         result.put("msg","电表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("updateW")
    public void updateW(waterModel water,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        ms.updateW(water);
        result.put("msg","水表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("updateG")
    public void updateG(gasModel gas,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        ms.updateG(gas);
        result.put("msg","气表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
