package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.roomModel;
import com.xyk.service.roomService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
    //更新房间信息
    @RequestMapping("/update")
    public void update(HttpServletResponse response,roomModel a)
    {
        JSONObject result=new JSONObject();
        roomservice.update(a);
        result.put("result","更新成功");
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/add")
    public void add(HttpServletResponse response,roomModel a)
    {
        JSONObject result=new JSONObject();
        roomservice.add(a);
        result.put("result","添加成功");
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/del")
    public void del(HttpServletResponse response, HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        String room_id=request.getParameter("room_id");
        roomservice.del(room_id);
        result.put("result","删除成功");
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
