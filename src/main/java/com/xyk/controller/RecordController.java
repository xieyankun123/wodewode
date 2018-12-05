package com.xyk.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xyk.model.apdataModel;
import com.xyk.model.echartsModel;
import com.xyk.service.*;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.json.Json;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/echarts")
public class RecordController {
    @Resource
    private yqService ys;
    @Resource
    private userService us;
    @Resource
    private roomService rs;
    @Resource
    private gyService gs;
    @Resource
    private u_rService ur;
    @Resource
    private apService as;
    @Resource
    private apdataService ads;
    @RequestMapping("/ele")
    public void ele(HttpServletResponse response, HttpServletRequest request) {
        JSONObject result = new JSONObject();
        String apparatus_id = request.getParameter("apparatus_id");
        String user_telephone = request.getParameter("user_telephone");
        System.out.println(user_telephone);
        System.out.println(apparatus_id);
//        if(apparatus_id.endsWith("0")==true) {
//            System.out.println("test1");
//            List<echartsModel> a = ads.getdv(apparatus_id);
//            System.out.println("test2");
//            if (a.size() <= 50) {
//                result.put("result", a);
//            } else {
//                while (true) {
//                    if (a.size() > 50) {
//                        a.remove(0);
//                    } else {
//                        break;
//                    }
//                }
//                result.put("result", a);
//            }
//        }
//        else
//        {
            List<apdataModel> apdata1 = ads.getdv0(user_telephone, apparatus_id);
            System.out.println(apdata1.size());
            List<echartsModel> a=new ArrayList<echartsModel>();
            if(apdata1.size()==0){}
            else if(apdata1.size()==1)
            {
                echartsModel aa=new echartsModel(apdata1.get(0).getTime(),apdata1.get(0).getValue());
                a.add(aa);
                result.put("result", a);
            }
            else {
                a.add(new echartsModel(apdata1.get(0).getTime(),apdata1.get(0).getValue()));
                for (int j = 1; j < apdata1.size(); j++) {
                    Double value = Double.parseDouble(apdata1.get(j).getValue()) - Double.parseDouble(apdata1.get(j - 1).getValue());
                    DecimalFormat df = new DecimalFormat("0.00");
                    String valu = df.format(value);
                    echartsModel b=new echartsModel(apdata1.get(j).getTime(),valu);
                    a.add(b);
                }
                result.put("result", a);
            }
//        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
//    @RequestMapping("/power")
//    public void power(HttpServletResponse response, HttpServletRequest request) {
//        JSONObject result = new JSONObject();
//        String apparatus_id = request.getParameter("apparatus_id");
//        List<echartsModel> a = ads.getpv(apparatus_id);
//        if (a.size() <= 500) {
//            result.put("result", a);
//        } else {
//            while (true) {
//                if (a.size() > 500) {
//                    a.remove(0);
//                } else {
//                    break;
//                }
//            }
//            result.put("result", a);
//        }
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
//    }
//    @RequestMapping("/power1")
//    public void power1(HttpServletRequest request,HttpServletResponse response)
//    {
//        JSONObject result=new JSONObject();
//        result.put("msg","10001");
//        String apparatus_id=request.getParameter("apparatus_id");
//        String date=request.getParameter("date");
//        List<apdataModel> apdataModels = ads.selbyidP(apparatus_id);
//        List<apdataModel> apdataModels1=new ArrayList<apdataModel>();
//        for(int i=0;i<apdataModels.size();i++)
//        {
//            if(apdataModels.get(i).getTime().substring(0,10).equals(date))
//            {
//                apdataModels1.add(apdataModels.get(i));
//            }
//        }
//        result.put("msg",apdataModels1);
//        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
//    }
}
