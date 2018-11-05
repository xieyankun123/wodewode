package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.roomModel;
import com.xyk.service.*;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/room")
public class roomController {
    @Resource
    private roomService roomservice;
    @Resource
    private gyService gs;
    @Resource
    private userService us;
    @Resource
    private u_rService ur;
    //房间列表
    @RequestMapping("/house_list")
    public ModelAndView list(HttpServletResponse response)
    {
        ModelAndView mv=new ModelAndView();
        //JSONObject result=new JSONObject();
       // result.put("result","10001");
        List<roomModel> a=roomservice.list();
        System.out.println(1);
        for(int i=0;i<a.size();i++)
        {
            System.out.println(2);
            a.get(i).setOwn(gs.selbyid(a.get(i).getApartment_id()).getOwner());
        }
        for(int i=0;i<a.size();i++)
        {
            if(a.get(i).getUseable()!=0) {
                if (ur.selbyRid(a.get(i).getRoom_id()).size() > 0)
                {if(us.selbytel(ur.selbyRid(a.get(i).getRoom_id()).get(ur.selbyRid(a.get(i).getRoom_id()).size() - 1).getUser_telephone()).getUser_state().equals("1"))
                    a.get(i).setXianzuke(us.selbytel(ur.selbyRid(a.get(i).getRoom_id()).get(ur.selbyRid(a.get(i).getRoom_id()).size() - 1).getUser_telephone()).getUser_name());
                } }
        }
        mv.addObject("house",a);
        mv.setViewName("house_list");
        return mv;
       // result.put("result",a);
       // result.put("msg","success");
       // HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //更新房间信息
    @RequestMapping("/update")
    public void update(HttpServletResponse response,roomModel a)
    {
        roomservice.update(a);
        JSONObject result = new JSONObject();
        try {
            boolean b=roomservice.update(a);
            if(b)
            {
                result.put("msg","更新成功");
            }
            else
            {
                result.put("msg","更新失败,没有此房间");
            }
        }
        catch (Exception e)
        {
            result.put("msg2","缺失参数");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/add")
    public void add(HttpServletResponse response,roomModel a)
    {
        JSONObject result = new JSONObject();
        try {
            boolean b= roomservice.add(a);
            if(b)
            {
                result.put("msg","存储成功");
            }
        }
        catch (Exception e)
        {
            result.put("msg1",e);
            result.put("msg2","参数错误添加失败");
        }
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
