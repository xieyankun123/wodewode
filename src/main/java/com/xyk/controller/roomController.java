package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.gyModel;
import com.xyk.model.managerModel;
import com.xyk.model.roomModel;
import com.xyk.model.u_rModel;
import com.xyk.service.*;
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
import java.util.stream.Stream;

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
    public ModelAndView list(HttpServletResponse response,HttpServletRequest request)
    {
        ModelAndView mv=new ModelAndView();
        //JSONObject result=new JSONObject();
       // result.put("result","10001");
        List<roomModel> aa=roomservice.list();
        managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
        if("0".equals(managerModel.getFactory()))
        {
            //计划去掉
            for(int i=0;i<aa.size();i++)
            {
                String q = aa.get(i).getFactory();
                aa.get(i).setOwn(gs.selbyid(aa.get(i).getApartment_id()).stream().filter(k->k.getFactory().equals(q)).collect(Collectors.toList()).get(0).getOwner());
            }
            for(int i=0;i<aa.size();i++) {
                if (aa.get(i).getUseable() != 0) {
                    if (ur.selbyRid(aa.get(i).getRoom_id()).size() > 0) {
                        String q = aa.get(i).getFactory();
                        List<u_rModel> collect = ur.selbyRid(aa.get(i).getRoom_id()).stream().filter(k -> k.getFactory().equals(q)).collect(Collectors.toList());
                        if (collect.size() > 0) {
                            aa.get(i).setXianzuke(us.selbytel(collect.get(collect.size() - 1).getUser_telephone()).getUser_name());
                        }
                    }
                }
            }
            mv.addObject("house",aa);
        }
        else {
            List<roomModel> a = aa.stream().filter(aaa -> aaa.getFactory().equals(managerModel.getFactory())).collect(Collectors.toList());
            for (int i = 0; i < a.size(); i++) {
                a.get(i).setOwn(gs.selbyid(a.get(i).getApartment_id()).stream().filter(aaa -> aaa.getFactory().equals(managerModel.getFactory())).collect(Collectors.toList()).get(0).getOwner());
            }
            for(int i=0;i<a.size();i++) {
                if (a.get(i).getUseable() != 0) {
                    if (ur.selbyRid(a.get(i).getRoom_id()).size() > 0) {
                        String q = a.get(i).getFactory();
                        List<u_rModel> collect = ur.selbyRid(a.get(i).getRoom_id()).stream().filter(k -> k.getFactory().equals(q)).collect(Collectors.toList());
                        if (collect.size() > 0) {
                            a.get(i).setXianzuke(us.selbytel(collect.get(collect.size() - 1).getUser_telephone()).getUser_name());
                        }
                        }
                }
            }
            mv.addObject("house", a);
        }
        List<gyModel> gyModels = gs.list().stream().filter(b -> b.getFactory().equals(managerModel.getFactory())).collect(Collectors.toList());
        mv.addObject("list",gyModels);
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
    public void add(HttpServletResponse response,roomModel a,HttpServletRequest request)
    {
        JSONObject result = new JSONObject();
        managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
        try {
            a.setFactory(managerModel.getFactory());
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
