package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.UserModel;
import com.xyk.model.yqModel;
import com.xyk.service.userService;
import com.xyk.service.yqService;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/apparatus")
public class yqController {
    @Resource
    private yqService ys;
    @Resource
    private userService us;
    @RequestMapping("/")
    public void list(HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        result.put("list",ys.list());
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/update")
    public void update(HttpServletResponse response,yqModel yq)
    {
        JSONObject result=new JSONObject();
        ys.update(yq);
        result.put("msg","更新成功");
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/yqinfoU")
    public void yqinfoU(HttpServletRequest request,int id, HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String room_id=request.getParameter("room_id");
        UserModel user=us.selbyid(id);
        result.put("msg1",user);
        if(room_id.endsWith("0")) {
            List<yqModel> apparatus0 = ys.selbyRid(room_id);
            result.put("msg2",apparatus0);
            result.put("resule","10013");
        }
        else
        {
            List<yqModel> apparatus1 = ys.selbyRid(room_id);
            StringBuilder a=new StringBuilder(room_id);
            a.setCharAt(4, '0');
            List<yqModel> apparatus0 = ys.selbyRid(a.toString());
            System.out.println(a.toString());
            result.put("msg2",apparatus1);
            result.put("msg3",apparatus0);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/updateYQ")
    public void updateYQ(HttpServletResponse response,HttpServletRequest request,int id){
        JSONObject result=new JSONObject();
        String yqid=request.getParameter("apparatus_id");
        try {
            yqModel yq=ys.selbyid(yqid);
            int useable=yq.getUseable();
            System.out.println(useable);
            if(useable==0)
            {
                ys.upbyid(id,yqid);
                result.put("msg","启动成功");
            }
            else
            {
                if(useable==id)
                { ys.upbyid(0,yqid);
                    result.put("msg","关闭成功");}
                else
                {
                    result.put("msg","有人正在使用");
                }
            }
        }
        catch(Exception e)
        {
            result.put("msg",e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}
