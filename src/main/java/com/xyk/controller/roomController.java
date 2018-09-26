package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.roomModel;
import com.xyk.service.roomService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/room")
public class roomController {
    @Resource
    private roomService roomservice;
    //房间列表
    @RequestMapping("/")
    public void list(HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        result.put("result","10001");
        List<roomModel> a=roomservice.list();
        result.put("result",a);
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //查询未在使用的房间
    @RequestMapping("/use0")
    public void use0(HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        List<roomModel> a=roomservice.selbyR0(0);
        result.put("result",a);
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
}
