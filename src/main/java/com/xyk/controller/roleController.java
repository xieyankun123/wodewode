package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.managerModel;
import com.xyk.model.roleModel;
import com.xyk.service.roleService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("role")
public class roleController {
    @Resource
    private roleService rs;
    //列表
    @RequestMapping("/")
    public void list(HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        List<roleModel> a=rs.list();
        result.put("result",a);
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //更新权限信息
    @RequestMapping("/update")
    public void update(HttpServletResponse response,roleModel a)
    {
        JSONObject result=new JSONObject();
        rs.update(a);
        result.put("result","更新成功");
        result.put("msg","success");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //增加权限信息
    @RequestMapping("/add")
    public void add(HttpServletResponse response,roleModel a)
    {
        JSONObject result=new JSONObject();
        try {
            boolean b = rs.add(a);
            if (b == true) {
                result.put("result", "插入成功");
                result.put("msg", "success");
            } else {
                result.put("result", "插入失败");
                result.put("msg", "false");
            }
        }
        catch (Exception e)
        {
            result.put("msg", e);
            result.put("result", "10005");
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //删除权限
    @RequestMapping("/del")
    public void del(HttpServletRequest request, HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String tel=request.getParameter("role_id");
        try{rs.del(tel);
            result.put("msg","success");
            result.put("result","10006");
        }
        catch (Exception e)
        {
            result.put("msg","false"+" "+e);
            result.put("result","10007");
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
