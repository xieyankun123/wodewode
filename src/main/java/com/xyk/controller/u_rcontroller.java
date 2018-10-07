package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.roomModel;
import com.xyk.model.u_rModel;
import com.xyk.service.roomService;
import com.xyk.service.u_rService;
import com.xyk.service.userService;
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
public class u_rController {
    @Resource
    private u_rService ur;
    @Resource
    private userService us;
    @Resource
    private roomService rs;
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
    @RequestMapping("/historyU")
    public void historyU(HttpServletResponse response,int id,HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        UserModel user=us.selbyid(id);
        result.put("msg1",user);
        String a=user.getUser_telephone();
        List<u_rModel> user_room=ur.selbyUtel(a);
        result.put("msg2",user_room);
        result.put("result","10011");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/historyR")
    public void historyR(HttpServletResponse response,HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        String room_id=request.getParameter("room_id");
        roomModel room=rs.selbyRid(room_id);
        result.put("msg1",room);
        List<u_rModel> user_room=ur.selbyRid(room_id);
        result.put("msg2",user_room);
        result.put("result","10012");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
