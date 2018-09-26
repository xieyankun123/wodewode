package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.service.userService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/user")
public class userController {
    @Resource
    private userService userservice;
    @RequestMapping("/")
    public ModelAndView list(HttpServletResponse response)
    {
      /*List<UserModel> a=userservice.list();
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        result.put("aaa",a);
        result.put("result","10003");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));*/
        List<UserModel> a=userservice.list();
        ModelAndView modelAndView = new ModelAndView();
        //将返回给页面的数据放入模型和视图对象中
        modelAndView.addObject("userList",a);
        //指定返回的页面位置
        modelAndView.setViewName("user");
        return modelAndView;
    }
    @RequestMapping("/del")
    public String del(int id,HttpServletRequest request,HttpServletResponse response)
    {
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
            userservice.del(id);
            return "redirect:/user/";
    }
    @RequestMapping("/update")
    public String update(UserModel userModel,HttpServletRequest request,Model model)
    {
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        boolean a=userservice.update(userModel);
//        if(a==true)
//        {
//            result.put("success","更新成功");
//            result.put("result","10006");
//        }
//        else
//        {   result.put("false","更新失败");
//            result.put("result","10007");
//        }
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        userservice.update(userModel);
        return "redirect:/user/";

    }
    @RequestMapping("/selectbyname")
    public void selbyname(HttpServletRequest request, HttpServletResponse response)
    {
        //response.setContentType("text/html;charset=utf-8");
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        String b=request.getParameter("user_name");
//        List<UserModel> a=userservice.selbyname(b);
//        result.put("rrr",a);
//        result.put("result","10002");
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));


    }
    @RequestMapping("/selectbytel")
    public ModelAndView selbytel(HttpServletRequest request,HttpServletResponse response)
    {
        // response.setContentType("text/html;charset=utf-8");
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        String tel=request.getParameter("user_telephone");
//        List<UserModel> a=userservice.selbytel(tel);
//        result.put("aaa",a);
//        result.put("result","10003");
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        String b=request.getParameter("user_telephone");
        List<UserModel> a=userservice.selbytel(b);
        UserModel c=a.get(0);
        ModelAndView modelAndView = new ModelAndView();
        //将返回给页面的数据放入模型和视图对象中
        modelAndView.addObject("user",c);
        //指定返回的页面位置
        modelAndView.setViewName("edituser");
        return modelAndView;
    }
    @RequestMapping("/toadd")
   public String toAddUser(){
             return "/adduser";
          }

    @RequestMapping("/add")
    public String add(UserModel userModel,HttpServletResponse response)
    {
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        int a=userservice.add(userModel);
//        if(a==0)
//        {
//            result.put("aaa","存储成功");
//        }
//        else
//        {
//            result.put("nnn","存储失败");
//        }
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
            userservice.add(userModel);
            return "redirect:/user/";

    }
}
