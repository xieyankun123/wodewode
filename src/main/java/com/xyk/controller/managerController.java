package com.xyk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xyk.model.managerModel;
import com.xyk.service.managerService;
import com.xyk.util.*;
import org.junit.jupiter.api.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mg")
public class managerController {
    @Resource
    private managerService ms;
    //列表
    @RequestMapping("/")
    public void list(HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        List<managerModel> a=ms.list();
        result.put("result",a);
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //通过手机号获取权限
    @RequestMapping("/getqx")
    public void getqx(HttpServletResponse response, HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        String a=request.getParameter("manager_telephone");
        String b=ms.getqx(a);
        result.put("result",b);
        result.put("msg","权限");
       HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //增加管理员
    @RequestMapping("/add")
    public void add(HttpServletResponse response,managerModel a)
    {
        JSONObject result=new JSONObject();
        boolean b=ms.add(a);
        if(b==true)
        {
            result.put("result","插入成功");
            result.put("msg","success");
        }
        else
        {
            result.put("result","插入失败");
            result.put("msg","false");
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //批量删除
    @RequestMapping("/delALL")
      public void delALL(HttpServletRequest request, HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream) request.getInputStream()));
            String line = null;
            StringBuilder sb = new StringBuilder();
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            System.out.println(sb);
            String s1 = sb.toString();
            JSONObject obj = JSON.parseObject(s1);
            System.out.println(obj.toString());
            String getjsay = obj.getString("ids");
            JSONArray obj1 = JSON.parseArray(getjsay);
            System.out.println(obj1);
            String[] a=obj1.toString().replace("[","").replace("]","").replace("\"","").split(",");
            System.out.print(a.length);
            for(int i=0;i<a.length;i++)
                System.out.println(a[i]);
            ms.delAll(a);
            result.put("msg","success");
        }catch(Exception e)
        {
            result.put("msg",e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    public static final String pic= "uploadpic/head_pic/";
    //上传图片
    @RequestMapping("/headpic")
    @ResponseBody
    public String uploade(HttpServletRequest request,
                          @RequestParam(value = "file", required = false) MultipartFile file) {
        String  ffile = DateUtil.getDays(), fileName = "";
        System.out.println(ffile);
        if (null != file && !file.isEmpty()) {
            String filePath = PathUtil.getClasspath() + pic + ffile;		//文件上传路径
            System.out.println(filePath);
            fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
        }
        return ffile + "/" + fileName;
    }
    public String get32UUID(){
        return UuidUtil.get32UUID();
    }
    //删除图片
    @RequestMapping(value="/delpic")
    public void delpic(HttpServletResponse response,managerModel mm) {
        JSONObject result=new JSONObject();
        try{
           String a=mm.getManager_telephone();
           String b=mm.getHeadpic();
           //删除操作
            DelAllFile.delFolder(PathUtil.getClasspath()+ pic + b);
            if(a!= null){
                mm.setHeadpic("");
                ms.updatepic(mm);												//删除数据中图片数据
            }
            result.put("msg","删除成功");
        }catch(Exception e){
            result.put("msg",e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/login")
    public void getdenglu(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        String manager_telephone = (String)request.getParameter("manager_telephone");
        String password = (String)request.getParameter("password");

            if(manager_telephone=="")
                        {result.put("errMsg", "账号不能为空");
                           result.put("result","10004");}
                  else {
                        try {
                               managerModel a = ms.login(manager_telephone, password);
                         if (a == null) {
                                       result.put("errMsg", "用户名或密码错误");
                                        result.put("result","10002");
                                   } else {
                                        result.put("ehahah", "登陆成功");
                                         result.put("result","10000");
                                     }
                                 } catch (Exception e) {
                                   result.put("essMsg", e.getMessage());
                                 }
                       }
                   HttpOutUtil.outData(response, JSONObject.toJSONString(result));
                 }
}


