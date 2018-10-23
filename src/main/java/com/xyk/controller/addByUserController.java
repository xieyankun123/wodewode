package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.addByUserModel;
import com.xyk.service.addByUserService;
import com.xyk.service.userService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/byuser")
public class addByUserController {
    @Resource
    private addByUserService abs;
    @Resource
    private userService us;
    @RequestMapping("/addbyuser")
    public void add(HttpServletResponse response, addByUserModel a)
    {
        JSONObject result=new JSONObject();
        try {
            List<addByUserModel> am=abs.selbyuser(a.getByuser());
            if(am.size()<3) {
                boolean b = abs.add(a);
                result.put("msg",b);
            }
            else
            {
                result.put("msg","您添加的人数过多");
            }
        }
        catch (Exception e)
        {result.put("msg",e);}
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/selbyuser")
    public void selbyuser(HttpServletResponse response, HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        String user_telephone=request.getParameter("user_telephone");
        try{
            List<addByUserModel> a=abs.selbyuser(user_telephone);
            result.put("list",a);
        }
        catch (Exception e)
        {result.put("msg",e);}
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
