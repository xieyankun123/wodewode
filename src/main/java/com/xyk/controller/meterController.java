package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.*;
import com.xyk.service.*;
import com.xyk.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
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
    @Resource
    private gyService gs;
    @RequestMapping("/sdq")
    public ModelAndView sdq(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView mv=new ModelAndView();
        String user_telephone=request.getParameter("user_telephone");
        UserModel user=us.selbytel(user_telephone);
        mv.addObject("user",user);
        String room_id=request.getParameter("room_id");
        roomModel room=rs.selbyRid(room_id);
        String apid=room.getApartment_id();
        room.setOwn(gs.selbyid(apid).getOwner());
        mv.addObject("room",room);
        List<waterModel> water=ms.selbyWID(apid);
        List<dianModel> dian=ms.selbyAID(apid);
        List<gasModel> gas=ms.selbyGID(apid);
        mv.addObject("water",water);
        mv.addObject("dian",dian);
        mv.addObject("gas",gas);
        mv.setViewName("user_water_account");
        return mv;
    }
    @RequestMapping("/getbyUid")
    public void getbyUid(HttpServletResponse response,HttpServletRequest request)
    {
        String user_telephone=request.getParameter("user_telephone");
        JSONObject result=new JSONObject();
        UserModel user=us.selbytel(user_telephone);
        List<dianModel> a=ms.selbyAUid(user_telephone);
        List<gasModel> b=ms.selbyGUid(user_telephone);
        List<waterModel> c=ms.selbyWUid(user_telephone);
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
        System.out.println(apid);
        List<dianModel> a=ms.selbyAID(apid);
        List<gasModel> b=ms.selbyGID(apid);
        List<waterModel> c=ms.selbyWID(apid);
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
        result.put("dian",a);
        result.put("gas",b);
        result.put("water",c);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    public String dat=new DateUtil().getDay();
    public String pic= "uploadpic/head_pic/"+dat+"";
    public String get32UUID(){
        return UuidUtil.get32UUID();
    }
    @RequestMapping("/insert")
    public void insert(HttpServletResponse response,HttpServletRequest request,@RequestParam(value = "file", required = false) MultipartFile file)
    {
        JSONObject result=new JSONObject();
        String user_id=request.getParameter("user_id");
        String meter=request.getParameter("meter");
        String room_id=ur.selbyUtel(user_id).get(ur.selbyUtel(user_id).size()-1).getRoom_id();
        String apid=rs.selbyRid(room_id).getApartment_id();
        DateUtil dat=new DateUtil();
        String date=dat.getDay();
        System.out.println(date);
        String  ffile = DateUtil.getDays(), fileName = "";
        System.out.println(ffile);
        if (null != file && !file.isEmpty()) {
            String filePath = PathUtil.getClasspath() + pic + ffile;		//文件上传路径
            System.out.println(filePath);
            fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
        }
       String filename=pic+ffile+ "/" + fileName;
        if(meter.equals("water"))
        {
            waterModel a=new waterModel();
            a.setPicture(filename);
            a.setUser_id(user_id);
            a.setWID_out(apid);
            a.setTime(date);
            ms.addW(a);
            result.put("msg","水表的信息插入成功");
        }
        else if(meter.equals("gas"))
        {
            gasModel a=new gasModel();
            a.setPicture(filename);
            a.setUser_id(user_id);
            a.setGID_out(apid);
            a.setTime(date);
            ms.addG(a);
            result.put("msg","气表的信息插入成功");
        }
        else if(meter.equals("dian"))
        {
            dianModel a=new dianModel();
            a.setPicture(filename);
            a.setUser_id(user_id);
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
    public void updateA(int id,HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String value=request.getParameter("value");
        ms.updateA(value,id);
         result.put("msg","电表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("updateW")
    public void updateW(int id,HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String value=request.getParameter("value");
        ms.updateW(value,id);
        result.put("msg","水表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("updateG")
    public void updateG(int id,HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String value=request.getParameter("value");
        ms.updateG(value,id);
        result.put("msg","气表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
