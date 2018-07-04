package com.wxm.controller;
import com.alibaba.fastjson.JSONObject;
import com.wxm.model.zhuceModel;
import com.wxm.service.IzhuceService;
import com.wxm.util.HttpOutUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/zhuce.req")
public class zhuceController {
    @Resource
    private IzhuceService izhuceservice;
    private static final Logger logger = LoggerFactory.getLogger(lolaController.class.getName());


    @RequestMapping(method = {RequestMethod.POST},params = "action=come")
    public void getzhuce(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        String username = (String)request.getParameter("username");
        String password = (String)request.getParameter("password");
        String password1= (String)request.getParameter("password1");
        logger.info("输入的账号密码为" + "  "+username+"   "+password);
        if (username == "") {
            result.put("errmsg","账号不能为空");
            result.put("result","10004");
        }
        else {
            if (username.matches("[a-zA-Z0-9]{3,5}") == false || password.matches("[a-zA-Z0-9]{3,5}") == false)
                {
                    result.put("errmsg","含有非法字符");
                    result.put("result","10003");
                 }
                 else
                     {
                            if (password.equals(password1) == false)
                            {
                                result.put("errmsg","密码不一致");
                                result.put("result","10002");
                            }
                            else {
                                    try {
                                          zhuceModel i = izhuceservice.reg(username, password);
                                        if (i == null)
                                             {
                                                 result.put("errmsg","注册成功");
                                                 result.put("result","10000");
                                             }
                                         else
                                             {
                                                 result.put("errmsg","账号已存在");
                                                 result.put("result","10001");
                                             }
                                         }
                                         catch (Exception e)
                                         {
                                             result.put("essMsg", e.getMessage());
                                        }
                                 }
                        }
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
}