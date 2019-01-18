package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.managerModel;
import com.xyk.service.managerService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/we")
public class webController {
    @Resource
    private managerService ms;
    @RequestMapping("/we_login")
    public String login_toLogin()
    {
        return "hh";
    }

    @RequestMapping("/enter")
    public String we_index(HttpServletRequest request, HttpServletResponse response)
    {
//        String manager_telephone = (String)request.getParameter("manager_telephone");
//        String password = (String)request.getParameter("password");
//        managerModel a = ms.login(manager_telephone, password);
//        HttpSession session = request.getSession();
//        if (a == null) {
//            System.out.println("登录失败！");
//        } else {
//            session.setAttribute("manager_telephone",manager_telephone);
//            System.out.println("登录成功");
//            return "success";
//        }
//        return null;
        return "success";
    }


}
