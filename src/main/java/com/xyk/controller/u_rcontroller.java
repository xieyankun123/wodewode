package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.roomModel;
import com.xyk.model.u_rModel;
import com.xyk.service.gyService;
import com.xyk.service.roomService;
import com.xyk.service.u_rService;
import com.xyk.service.userService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/u_r")
public class u_rController {
    @Resource
    private u_rService ur;
    @Resource
    private userService us;
    @Resource
    private roomService rs;
    @Resource
    private gyService gs;
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
    @RequestMapping("/update")
    public void update(u_rModel ur1, HttpServletRequest request, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        try {
            boolean a = ur.update(ur1);
            if (a) {
                result.put("msg", "更新成功");
            } else {
                result.put("msg", "更新失败");
            }
        } catch (Exception e) {
            result.put("msg2", "缺失参数");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/add")
    public void add(HttpServletRequest request,HttpServletResponse response,u_rModel ur1)
    {
        JSONObject result=new JSONObject();
        try {
            boolean a = ur.add(ur1) ;
            if (a) {
                result.put("msg", "存储成功");
            }
        } catch (Exception e) {
            result.put("msg1", e);
            result.put("msg2", "参数错误添加失败");
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
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
    @RequestMapping("/historyU")
    public ModelAndView historyU(HttpServletResponse response, HttpServletRequest request)
    {
        System.out.println("123");
        ModelAndView mv=new ModelAndView();
        System.out.println("123");
        String user_telephone=request.getParameter("user_telephone");
        System.out.println(user_telephone);
        //JSONObject result=new JSONObject();
        UserModel user=us.selbytel(user_telephone);
        //result.put("msg1",user);
        String a=user.getUser_telephone();
        List<u_rModel> user_room=ur.selbyUtel(a);
        mv.addObject("user",user);
        mv.addObject("user_room",user_room);
        mv.setViewName("user_history");
        return mv;

       // result.put("msg2",user_room);
       // result.put("result","10011");
       // HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/historyR")
    public ModelAndView historyR(HttpServletResponse response,HttpServletRequest request)
    {
        ModelAndView mv=new ModelAndView();

        //JSONObject result=new JSONObject();
        String room_id=request.getParameter("room_id");
        roomModel room=rs.selbyRid(room_id);
        room.setOwn(gs.selbyid(room.getApartment_id()).getOwner());
        if(ur.selbyRid(room.getRoom_id()).size()>0)
        room.setNum(ur.selbyRid(room.getRoom_id()).get(ur.selbyRid(room.getRoom_id()).size()-1).getUser_telephone());
        System.out.println("123"+room.getNum()+"123");
        mv.addObject("room",room);
        //result.put("msg1",room);
        List<u_rModel> user_room=ur.selbyRid(room_id);
        for(int i=0;i<user_room.size();i++)
        {
            user_room.get(i).setUsername(us.selbytel(user_room.get(i).getUser_telephone()).getUser_name());
        }
        mv.addObject("user_room",user_room);
        mv.setViewName("house_history");
        return mv;
       // result.put("msg2",user_room);
       // result.put("result","10012");
       // HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
