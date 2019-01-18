package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.addByUserModel;
import com.xyk.model.managerModel;
import com.xyk.service.addByUserService;
import com.xyk.service.userService;
import com.xyk.util.Cons;
import com.xyk.util.ExcelUtil;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
public class userController {
    @Resource
    private userService userservice;
    @Resource
    private addByUserService abs;
    @RequestMapping("/user_list")
    public ModelAndView list(HttpServletRequest request) {
//      List<UserModel> a=userservice.list();
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        result.put("aaa",a);
//        result.put("result","10003");
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        ModelAndView modelAndView = new ModelAndView();
        List<UserModel> a = userservice.list();
        managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
        if("0".equals(managerModel.getFactory()))
        {
            modelAndView.addObject("userList",a);
        }
        else {
            List<UserModel> c = a.stream().filter(b -> b.getFactory().equals(managerModel.getFactory())).collect(Collectors.toList());
            //将返回给页面的数据放入模型和视图对象中
            modelAndView.addObject("userList", c);
        }
        //指定返回的页面位置
        modelAndView.setViewName("user_list");
        return modelAndView;
    }

    @RequestMapping("/del")
    public String del(HttpServletRequest request, HttpServletResponse response) {
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        boolean a=userservice.del(id);
//        if(a==true)
//        {
//            result.put("success","删除成功");
//            result.put("result","10004");
//        }
//        else
//        {   result.put("false","删除失败");
//            result.put("result","10005");
//        }
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        String b = request.getParameter("user_telephone");
        userservice.del(b);
        return "redirect:/user/";
    }

    @RequestMapping("/update")
    public void update(UserModel userModel, HttpServletRequest request, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        try {
            boolean a = userservice.update(userModel);
            if (a) {
                result.put("msg", "更新成功");
            } else {
                result.put("msg", "更新失败，没有此用户");
            }
        } catch (Exception e) {
            result.put("msg2", "缺失参数");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //APP接口
    @RequestMapping("/weixinLogin")
    public void weixinLogin(HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String user_weixin=request.getParameter("user_weixin");
        List<UserModel> a=userservice.selbystate("1");
        result.put("msg",false);
        System.out.println(a.size());
        for(int i=0;i<a.size();i++) {

                if (a.get(i).getUser_weixin().equals(user_weixin)) {
                    String user_telephone = a.get(i).getUser_telephone();
                    result.put("msg", user_telephone);
                    break;
                }
                else
                {
                    List<addByUserModel> q=abs.selbyuser(a.get(i).getUser_telephone());
                    for(int j=0;j<q.size();j++)
                    {
                        boolean c=q.get(j).getWeixin().equals(user_weixin);
                        if(c)
                        {
                            result.put("msg",a.get(i).getUser_telephone());
                            break;
                        }
                    }
                }
            }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //APP接口
    @RequestMapping("/selectbystate")
    public void selbystate(HttpServletRequest request, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        String user_telephone=request.getParameter("user_telephone");
        String user_weixin=request.getParameter("user_weixin");
        List<UserModel> a=userservice.selbystate("1");
        result.put("msg",false);
        boolean flag1 = false;
        boolean flag2 = false;
        String tele=null;
        for(int i=0;i<a.size();i++)
        {
            boolean b=a.get(i).getUser_telephone().equals(user_telephone);
            if(b)
            {flag1=b;
                break;
            }
            List<addByUserModel> q=abs.selbyuser(a.get(i).getUser_telephone());
            for(int j=0;j<q.size();j++)
            {
                boolean c=q.get(j).getTelephone().equals(user_telephone);
                if(c)
                {flag2=c;
                System.out.println(a.get(i).getUser_telephone());
                tele=a.get(i).getUser_telephone();
                    break;
                }
            }
            if(flag2)
                break;
        }
        if(flag1||flag2)
        {
            if(flag1)
            {
                try{
                boolean b=userservice.addweixin(user_weixin,user_telephone);
                    result.put("msg",user_telephone);
                    }
            catch (Exception e)
            {result.put("msg",e);}
            }
            else{
                boolean b=abs.addweixin(user_weixin,user_telephone);
                result.put("msg",tele);
            }

        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }

    @RequestMapping("/selectTel")
    public void selbytel(HttpServletRequest request, HttpServletResponse response) {
         response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        String tel=request.getParameter("user_telephone");
        UserModel a=userservice.selbytel(tel);
        result.put("user",a);
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
//        String b = request.getParameter("user_telephone");
//        UserModel a = userservice.selbytel(b);
//        ModelAndView modelAndView = new ModelAndView();
//        //将返回给页面的数据放入模型和视图对象中
//        modelAndView.addObject("user", a);
//        //指定返回的页面位置
//        modelAndView.setViewName("edituser");
//        return modelAndView;
    }

    @RequestMapping("/add")
    public void add(UserModel userModel, HttpServletResponse response,HttpServletRequest request) {
        JSONObject result = new JSONObject();
        managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
        try {
            userModel.setFactory(managerModel.getFactory());
            userModel.setUser_weixin("");
            boolean a = userservice.add(userModel);
            if (a) {
                result.put("msg", "存储成功");
            }
        } catch (Exception e) {
            result.put("msg1", e);
            result.put("msg2", "参数错误添加失败");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //通过手机号添加微信号
    @RequestMapping("/addWeixin")
    public void addWeixin(HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String user_weixin=request.getParameter("user_weixin");
        String user_telephone=request.getParameter("user_telephone");
        System.out.println(user_telephone);
        System.out.println(user_weixin);
        try{
        boolean b=userservice.addweixin(user_weixin,user_telephone);
        result.put("msg",b);
        }
        catch (Exception e)
        {
            result.put("msg",e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    /*
     * 导出用户信息到EXCEL
     * @return
     */
    @RequestMapping("/export")
    public void export(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<UserModel> list = userservice.list();
        System.out.println(list.size());
        String fileName = "一个 Excel 文件";
        String sheetName = "第一个 sheet";
        ExcelUtil.writeExcel(response,list,fileName,sheetName,new UserModel());
    }

    @RequestMapping("/import")
    @ResponseBody
    public Object impotr(HttpServletResponse response,@RequestParam(value = "file", required = false) MultipartFile file) {
        JSONObject result=new JSONObject();
        result.put("msg","false");
        List<Object> userModels =ExcelUtil.readExcel(file, new UserModel(),1,1);
        for(Object users:userModels)
        {
            UserModel user= (UserModel)users;
            userservice.add(user);
        }
        result.put("msg","success");
        return result;
    }
}

