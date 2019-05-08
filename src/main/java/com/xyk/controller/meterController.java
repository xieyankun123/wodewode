package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.*;
import com.xyk.service.*;
import com.xyk.util.*;
import com.xyk.util.wenzishibie.shishi;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
//测试git
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@Controller
@Slf4j
@RequestMapping("/meter")
public class meterController {
    @Resource
    private meterService ms;
    @Resource
    private userService us;
    @Resource
    private gyService gs;
    @RequestMapping("/sdq1")
    public ModelAndView sdq1(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView mv=new ModelAndView();
        List<WatertotalModel> watertotalModels=new ArrayList<WatertotalModel>();
        String user_telephone=request.getParameter("user_telephone");
        UserModel user=us.selbytel(user_telephone);
        mv.addObject("user",user);
        String user_factory=user.getFactory();
        List<gyModel> collect = gs.list().stream().filter(b -> b.getFactory().equals(user_factory)).collect(Collectors.toList());
        for(gyModel a:collect)
        {
            List<waterrModel> collect1 = ms.list().stream().filter(b -> b.getFactory().equals(user_factory))
                    .filter(c -> c.getWID_out().equals(a.getApartment_id()))
                    .collect(Collectors.toList());
            Collections.reverse(collect1);
            List<waterrModel> type1 = collect1.stream()
                    .filter(c -> c.getType().equals("1"))
                    .collect(Collectors.toList());
            List<waterrModel> type2 = collect1.stream()
                    .filter(c -> c.getType().equals("2"))
                    .collect(Collectors.toList());
            List<waterrModel> type3 = collect1.stream()
                    .filter(c -> c.getType().equals("3"))
                    .collect(Collectors.toList());
            watertotalModels.add(new WatertotalModel(a,type1,type2,type3));
        }
        mv.addObject("list",watertotalModels);
        mv.setViewName("user_water_account");
        return mv;
    }
    public String dat=new DateUtil().getDay();
    public String pic= "uploadpic/head_pic/"+dat+"";
    public String get32UUID(){
        return UuidUtil.get32UUID();
    }
    //APP接口
    @RequestMapping("/insert")
    public void insert(HttpServletResponse response,HttpServletRequest request,@RequestParam(value = "file", required = false) MultipartFile file,@RequestParam(value = "picture", required = false)String picture)
    {
        JSONObject result=new JSONObject();
        String factory ="";
        String ffile = DateUtil.getDays(), fileName = "";
        DateUtil dat = new DateUtil();
        String date = dat.getTime();
        String user_id=request.getParameter("user_id");
        String type=request.getParameter("type");
        String WID_out=request.getParameter("WID_out");
        String imagename=request.getParameter("imagename");
        List<gyModel> collect = gs.list().stream().filter(b -> b.getApartment_id().equals(WID_out)).collect(Collectors.toList());
        if(collect.size()==0)
        {
            result.put("msg","This water meter does not exist.");
        }
        if(ContainerSingleton.getInstance("imagename").equals(imagename))
        {
            result.put("msg","this pic has been upload");
        }
        else {
            try {
                waterrModel a = new waterrModel();
                if(String.valueOf(user_id)=="null")
                {
                        a.setUser_id("自动拍摄");
                        factory = gs.selbyid(WID_out).get(0).getFactory();
                        String filename = pic + ffile + "/";
                        ImageUtil.generateImage(picture, PathUtil.getClasspath() + filename + imagename + ".png");
                        String picture1 = imagename + "\n" + picture + "\n";
                        if(Files.exists(Paths.get(PathUtil.getClasspath() + filename + DateUtil.getDays() + ".txt"))==false)
                        Files.createFile(Paths.get(PathUtil.getClasspath() + filename + DateUtil.getDays() + ".txt"));
                        Files.write(Paths.get(PathUtil.getClasspath() + filename + DateUtil.getDays() + ".txt"), picture1.getBytes("UTF-8"),StandardOpenOption.APPEND);
                        a.setPicture(filename + imagename + ".png");
                         ContainerSingleton.putInstance("imagename",imagename);
                }
                else {
                    a.setUser_id(user_id);
                    factory = us.selbytel(user_id).getFactory();
                    if (null != file && !file.isEmpty()) {
                        String filePath = PathUtil.getClasspath() + pic + ffile;        //文件上传路径
                        fileName = FileUpload.fileUp(file, filePath, this.get32UUID());                //执行上传
                    }
                    String filename = pic + ffile + "/" + fileName;
                    a.setPicture(filename);
                }
                a.setWID_out(WID_out);
                a.setTime(date);
                a.setFactory(factory);
                a.setType(type);
                ms.add(a);
                int id = a.getId();
                String picture1 = a.getPicture();
                String zzvalue="";
                try {
                    zzvalue = shishi.getzvalue(new File(PathUtil.getClasspath() + picture1));
                }
                catch (Exception e)
                {
                    zzvalue="无法识别";
                }
                log.info(String.valueOf(id));
                ms.updateZvalue(zzvalue,id);
                gs.updateTime(WID_out,date);
                result.put("msg", "Successful insertion of water meter information");
            } catch (Exception e) {
                result.put("msg", "Mobile number unauthorized");
                result.put("msg1", e);
            }
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("update")
    public void update(int id,HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String value=request.getParameter("value");
        managerModel attribute = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
        String time=DateUtil.getTime();
        ms.update(value,attribute.getManager_telephone(),time,id);
        result.put("msg","水表的更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/echarts1")
    @ResponseBody
    public JSONObject echarts1(HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String a=null;
        String water_id=request.getParameter("water_id");
        List<waterrModel> collect = ms.s(water_id);
        result.put("water",collect);
       return result;
    }
    //APP接口
    @RequestMapping("/getpic")
    public void getpic(int id,HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String picture="";
        List<waterrModel> collect = ms.list().stream().filter(b -> b.getId() == id).collect(Collectors.toList());
        //picture="https://zigzen.net/"+picture;
        picture="http://139.199.82.86:8080/jieshui/"+collect.get(0).getPicture();
        result.put("picurl",picture);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
//        picture=request.getRealPath("/")+"/"+picture;
//            File file=new File(picture);
//            try {
//                response.setHeader("content-disposition", "filename=" + URLEncoder.encode(picture, "UTF-8"));
//                FileInputStream in = new FileInputStream(file);
//                OutputStream out = response.getOutputStream();
//                byte buffer[] = new byte[1024];
//                int len = 0;
//                while((len=in.read(buffer))>0){
//                    out.write(buffer, 0, len);
//                }
//                in.close();
//                out.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
        }
    }
