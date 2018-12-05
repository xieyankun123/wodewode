package com;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.yqModel;
import com.xyk.service.*;
import com.xyk.util.HttpOutUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class yqControllerTest {
    @Resource
    private yqService ys;
    @Resource
    private u_rService ur;
    @Test
    public void yqinfo()
    {
        JSONObject result=new JSONObject();
        String user_telephone="18810625333";
        if(user_telephone.equals("false"))
        {
            result.put("msg","fail");
        }
        else {
            //UserModel user=us.selbytel(user_telephone);
            String room_id = ur.selbyUtel(user_telephone).get(ur.selbyUtel(user_telephone).size() - 1).getRoom_id();
            //roomModel room=rs.selbyRid(room_id);
            //room.setOwn(gs.selbyid(room.getApartment_id()).getOwner());
            // result.put("msg1",user);
//        if(room_id.endsWith("0")) {
//            List<yqModel> apparatus0 = ys.selbyRid(room_id);
//            mv.addObject("room")
//          //  result.put("msg2",apparatus0);
//          //  result.put("resule","10013");
//        }
//        else
//        {
            List<yqModel> apparatus1 = ys.selbyRid(room_id);
            if(apparatus1.size()==0)
            {result.put("msg1","10");}
            else
            {
                result.put("apparatus1", apparatus1);
            }
            StringBuilder a = new StringBuilder(room_id);
            a.setCharAt(4, '0');
            List<yqModel> apparatus0 = ys.selbyRid(a.toString());
            if(apparatus0.size()==0)
            {result.put("msg0","00");}
            else{
                result.put("apparatus0", apparatus0);
            }
        }
        System.out.println(result);
    }
}