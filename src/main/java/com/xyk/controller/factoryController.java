package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.factory;
import com.xyk.model.gyModel;
import com.xyk.model.managerModel;
import com.xyk.service.factoryService;
import com.xyk.service.gyService;
import com.xyk.util.Cons;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;
@Controller
@RequestMapping("/factory")
public class factoryController {
    @Resource
    private factoryService fservice;
    @RequestMapping("com_list")
    public ModelAndView list(HttpServletResponse response, HttpServletRequest request)
    {
        ModelAndView modelAndView = new ModelAndView();
        List<factory> a =fservice.list();
        modelAndView.addObject("comlist",a);
        //指定返回的页面位置
        modelAndView.setViewName("com_list");
        return modelAndView;
    }
    @RequestMapping("/add")
    public void add(factory g,HttpServletResponse response,HttpServletRequest request)
    {
        JSONObject result = new JSONObject();
        managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
        result.put("result", "10001");
        fservice.add(g);
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/update")
    public void update(factory g,HttpServletResponse response)
    {
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        fservice.update(g);
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
}
