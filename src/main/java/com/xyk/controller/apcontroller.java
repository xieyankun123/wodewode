package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.ApModel;
import com.xyk.service.apService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/ap")
public class apController {
    @Resource
    private apService apservice;
    @RequestMapping("/selectbyid")
    public void selbyid(HttpServletRequest request, HttpServletResponse response)
    {
        //response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        String apparatus_id=request.getParameter("apparatus_id");
        List<ApModel> a=apservice.selbyid(apparatus_id);
        result.put("rrr",a);
        result.put("result","10002");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/selectbyname")
    public void selbyname(HttpServletRequest request,HttpServletResponse response)
    {
       // response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        String name=request.getParameter("user_name_on");
        List<ApModel> a=apservice.selbyp(name);
        result.put("aaa",a);
        result.put("result","10003");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/")
    public void list(HttpServletResponse response)
    {
        List<ApModel> a = apservice.list();
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        result.put("aaa",a);
        result.put("result","10003");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        /*ModelAndView modelAndView = new ModelAndView();
        //将返回给页面的数据放入模型和视图对象中
        modelAndView.addObject("itemList",a);
        //指定返回的页面位置
        modelAndView.setViewName("itemList");
        return modelAndView;*/
    }
    @RequestMapping("/add")
    public void add(ApModel apModel,HttpServletResponse response)
    {
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        int a=apservice.add(apModel);
        if(a==0)
        {
            result.put("aaa","存储成功");
        }
        else
        {
            result.put("nnn","存储失败");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
}
