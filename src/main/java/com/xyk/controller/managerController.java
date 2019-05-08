package com.xyk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.apdataModel;
import com.xyk.model.factory;
import com.xyk.model.managerModel;
import com.xyk.service.*;
import com.xyk.util.*;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import static com.xyk.util.RandomValidateCode.RANDOMCODEKEY;
@Slf4j
@Controller
@RequestMapping("/mg")
public class managerController {
    @Resource
    private managerService ms;
    @Resource
    private userService us;
    @Resource
    private factoryService fs;
    //转去登录页面
    @RequestMapping("/login_toLogin")
    public String login_toLogin()
    {
        return "login";
    }
    //主页面
    @RequestMapping("/index")
    public  ModelAndView index(HttpServletRequest request)
    {
        log.info("是拦截之后吗?");
        ModelAndView mv=new ModelAndView();
        HttpSession session = request.getSession();
        log.info(session.getId());
        session.setMaxInactiveInterval(60*60);
        managerModel mm = (managerModel)session.getAttribute(Cons.MANAGER);
        mv.addObject("mm",mm);
        mv.setViewName("index");
        return mv;
    }
    @RequestMapping("/home")
    public String home()
    {
        return "home";
    }
    @RequestMapping("/guanliyuan")
    public ModelAndView home1(HttpServletRequest request)
    {
        List<factory> factories=new ArrayList<factory>();
        ModelAndView mv=new ModelAndView();
        String manager_telephone=request.getParameter("manager_telephone");
        managerModel mm=ms.selbytel(manager_telephone);
        mv.addObject("mm",mm);
       // JSONObject result=new JSONObject();

        if(mm.getRole().equals("超级管理员"))
        {
            List<managerModel> a=ms.list();
            List<factory> factoryList = fs.list();
            System.out.println(factoryList.get(0).getFacotry());
            mv.addObject("factorylist",factoryList);
       // result.put("mg",a);
        mv.addObject("mg",a);}
        //HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        else if(mm.getRole().equals("系统管理员"))
        {
            List<managerModel> selbyfac = ms.selbyfac(mm.getFactory());
            mv.addObject("mg",selbyfac);
            factory factoryList=new factory();
            factoryList.setFacotry(mm.getFactory());
            factoryList.setId(1);
            factories.add(factoryList);
            mv.addObject("factorylist",factories);
        }
        else if(mm.getRole().equals("普通管理员"))
        {
            List<managerModel> a = ms.selbyfac(mm.getFactory());
            Stream<managerModel> aa = a.stream().filter(b -> b.getRole().equals("普通管理员"));
            List<managerModel> collect = aa.collect(Collectors.toList());
            mv.addObject("mg",collect);
            factory factoryList=new factory();
            factoryList.setFacotry(mm.getFactory());
            factoryList.setId(1);
            factories.add(factoryList);

            mv.addObject("factorylist",factories);
        }
        mv.setViewName("administrator");
        return mv;
    }
    @RequestMapping("/quanxian")
    public String home2()
    {
        return "admin_Competence";
    }
//    //列表
//    @RequestMapping("/")
//    public void list(HttpServletResponse response)
//    {
//
//    }
    //更新管理员信息
    @RequestMapping("/update")
    public void update(HttpServletResponse response,managerModel a)
    {

        JSONObject result = new JSONObject();
        try {
            boolean b=ms.update(a);
            if(b)
            {
                result.put("msg","更新成功");
            }
            else
            {
                result.put("msg","更新失败，没有此用户");
            }
        }
        catch (Exception e)
        {
            result.put("msg2","缺失参数");
        }
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
    public void add(HttpServletResponse response,managerModel a,HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        try {
            boolean b = ms.add(a);
            if (b) {
                result.put("msg", "插入成功");
            } else {
                result.put("msg", "插入失败");
            }
        }
        catch (Exception e)
        {
            result.put("msg", "信息不完整或者手机号已存在"+e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //删除管理员

    //批量删除
//    @RequestMapping("/delALL")
//      public void delALL(HttpServletRequest request, HttpServletResponse response)
//    {
//        JSONObject result=new JSONObject();
//        try {
//            BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream) request.getInputStream()));
//            String line = null;
//            StringBuilder sb = new StringBuilder();
//            while ((line = br.readLine()) != null) {
//                sb.append(line);
//            }
//            System.out.println(sb);
//            String s1 = sb.toString();
//            JSONObject obj = JSON.parseObject(s1);
//            System.out.println(obj.toString());
//            String getjsay = obj.getString("ids");
//            System.out.println(getjsay);
//            JSONArray obj1 = JSON.parseArray(getjsay);
//            System.out.println(obj1);
//            String[] a=obj1.toString().replace("[","").replace("]","").replace("\"","").split(",");
//            System.out.print(a.length);
//            for(int i=0;i<a.length;i++)
//                System.out.println(a[i]);
//            ms.delAll(a);
//            result.put("msg","success");
//        }catch(Exception e)
//        {
//            result.put("msg",e);
//        }
//        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
//    }
    public static final String pic= "uploadpic/head_pic/";
//    //上传图片
//    @RequestMapping("/headpic")
//    @ResponseBody
//    public String uploade(HttpServletRequest request,
//                          @RequestParam(value = "file", required = false) MultipartFile file) {
//        String  ffile = DateUtil.getDays(), fileName = "";
//        System.out.println(ffile);
//        if (null != file && !file.isEmpty()) {
//            String filePath = PathUtil.getClasspath() + pic + ffile;		//文件上传路径
//            System.out.println(filePath);
//            fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
//        }
//        return ffile + "/" + fileName;
//    }
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
    @RequestMapping(value="/checkCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //设置相应类型,告诉浏览器输出的内容为图片
        response.setContentType("image/jpeg");
        //设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);

        RandomValidateCode randomValidateCode = new RandomValidateCode();
        try {
            randomValidateCode.getRandcode(request, response);//输出图片方法
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/login")
    public void getdenglu(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject result = new JSONObject();
        String manager_telephone = (String)request.getParameter("manager_telephone");
        String password = (String)request.getParameter("password");
        String code=request.getParameter("code");
        HttpSession session = request.getSession();
        String b= (String) session.getAttribute(RANDOMCODEKEY);
        if(code.equals(b))
        {
            log.info("fing manager-1");

            if (manager_telephone == "") {
              //  result.put("errMsg", "账号不能为空");
                result.put("result", "10004");
            } else {
                log.info("fing manager0");
                try {
                    managerModel a = ms.login(manager_telephone, password);
                    if (a == null) {
                       // result.put("errMsg", "用户名或密码错误");
                        result.put("result", "10002");
                    } else {
                        log.info("fing manager");
                        managerModel selbytel = ms.selbytel(manager_telephone);
                        log.info("fing manager1");
                        session.setAttribute(Cons.MANAGER,selbytel);
                        log.info("fing manager2");
                        //解决中文编码问题
                        String encode = URLEncoder.encode(selbytel.toString(), "UTF-8");
                        Cookie cookie=new Cookie("sessionid",encode);
                        cookie.setMaxAge(60*60*24);
                        //cookie.setDomain(".qiboyongxun.cn");
                        log.info("fing manager3");
                        response.addCookie(cookie);
                        log.info("fing manager4");
                        //result.put("ehahah", "登陆成功");
                        result.put("result", "10005");
                    }
                } catch (Exception e) {
                    log.info("yichang");
                    log.info(e.getMessage());
                    result.put("essMsg", e.getMessage());
                }
            }
        }
        else{
          //  result.put("msg", "验证码错误");
            result.put("result", "10000");
        }
                   HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/homepage")
    public void homepage(HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        List<UserModel> a=us.list();
        result.put("length",a.size());
        System.out.println(a.size());
        result.put("result",10007);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}



