package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.u_rModel;
import com.xyk.service.u_rService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/u_r")
public class u_rcontroller {
    @Resource
    private u_rService ur;
    //列表
    @RequestMapping("/")
    public void list(HttpServletResponse response)
    {
       List<u_rModel> a=ur.list();
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        result.put("aaa",a);
        result.put("result","10003");
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }

    @RequestMapping("/intoout")
    public void intoout(HttpServletResponse response)
    {
        JSONObject result = new JSONObject();
        result.put("result", "10001");
        u_rModel b=ur.selbyid(1);
         String bb=b.getIn_time();
         String cc=b.getOut_time();
        String ccc=bb.substring(0,9);
        String ddd=cc.substring(0,9);
        result.put("result",ccc.replaceAll("-","/")+"-"+ddd.replaceAll("-","/"));
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }

}
