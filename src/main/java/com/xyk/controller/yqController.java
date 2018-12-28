package com.xyk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;
import com.xyk.model.*;
import com.xyk.service.*;
import com.xyk.util.Cons;
import com.xyk.util.DateUtil;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.json.Json;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/apparatus")
public class yqController{
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
    @RequestMapping("/tp")
    public ModelAndView tp(HttpServletRequest request)
    {
        ModelAndView mv=new ModelAndView();
        String apparatus_id=request.getParameter("apparatus_id");
        String user_telephone=request.getParameter("user_telephone");
        mv.addObject("apparatus_id",apparatus_id);
        mv.addObject("user_telephone",user_telephone);
        mv.setViewName("zhexian");
        return mv;
    }
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
    //APP接口
    @RequestMapping("/yqinfo")
    public void yqinfo(HttpServletRequest request, HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String user_telephone=request.getParameter("user_telephone");
        String factory=us.selbytel(user_telephone).getFactory();
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
            List<yqModel> apparatus1 = ys.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            if(apparatus1.size()==0)
            {result.put("msg1","10");}
            else
            {
                result.put("apparatus1", apparatus1);
            }
            StringBuilder a = new StringBuilder(room_id);
            a.setCharAt(4, '0');
            List<yqModel> apparatus0 = ys.selbyRid(a.toString()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            if(apparatus0.size()==0)
            {result.put("msg0","00");}
            else{
            result.put("apparatus0", apparatus0);
            }
        }
         HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/yqinfoU")
    public ModelAndView yqinfoU(HttpServletRequest request, HttpServletResponse response)
    {
       // JSONObject result=new JSONObject();
        ModelAndView mv=new ModelAndView();
        String room_id=request.getParameter("room_id");
        String user_telephone=request.getParameter("user_telephone");
        UserModel user=us.selbytel(user_telephone);
        String factory= user.getFactory();
        roomModel room=rs.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList()).get(0);
        List<u_rModel> u_rModels = ur.selbyUtel(user_telephone);
        String intime=u_rModels.get(u_rModels.size()-1).getIn_time();
        String outtime=u_rModels.get(u_rModels.size()-1).getOut_time();
        room.setOwn(gs.selbyid(room.getApartment_id()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList()).get(0).getOwner());
        if(user.getUser_state().equals("1"))
        {
            mv.addObject("outtime","至今");
        }
        else
        {
            mv.addObject("outtime",outtime);
        }
        mv.addObject("intime",intime);
        mv.addObject("user",user);
        mv.addObject("room",room);
       // result.put("msg1",user);
//        if(room_id.endsWith("0")) {
//            List<yqModel> apparatus0 = ys.selbyRid(room_id);
//            mv.addObject("room")
//          //  result.put("msg2",apparatus0);
//          //  result.put("resule","10013");
//        }
//        else
//        {
            double sum1=0.00;
            double sum2=0.00;
            List<yqModel> apparatus1 = ys.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            StringBuilder a = new StringBuilder(room_id);
            a.setCharAt(4, '0');
            List<yqModel> apparatus0 = ys.selbyRid(a.toString()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            DecimalFormat df = new DecimalFormat("0.00");
            for(int i=0;i<apparatus1.size();i++)
            {
                List<apdataModel> apdata1 = ads.getdv0(user_telephone,apparatus1.get(i).getId());
                if(apdata1.size()==0)
                {apparatus1.get(i).setTotel("0.00");}
                else {
                    double aa=0;
                    for(int j=0;j<apdata1.size();j++) {
                        aa=Double.parseDouble(apdata1.get(j).getValue())+aa;
                    }
                    apparatus1.get(i).setTotel(df.format(aa));
                    sum1 = sum1 + aa;
                }
            }
            for(int i=0;i<apparatus0.size();i++)
            {
                List<apdataModel> apdata1 = ads.getdv0(user_telephone, apparatus0.get(i).getId());
                if(apdata1.size()==0){
                    apparatus0.get(i).setTotel("0.00");
                }
                else {
                    double bb=0;
                    for(int j=0;j<apdata1.size();j++) {
                        bb=Double.parseDouble(apdata1.get(j).getValue())+bb;
                    }
                    apparatus0.get(i).setTotel(df.format(bb));
                    sum2=sum2+bb;
                }
            }
            double sum3=sum1+sum2;
            mv.addObject("sum1",df.format(sum1));
            mv.addObject("sum2",df.format(sum2));
            mv.addObject("sum3",df.format(sum3));
            mv.addObject("apparatus1",apparatus1);
            mv.addObject("apparatus0",apparatus0);
            mv.setViewName("user_power_consumption");
            return mv;
           // result.put("msg2",apparatus1);
           // result.put("msg3",apparatus0);
       // }
       // HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/yqinfoR")
    public ModelAndView yqinfoR(HttpServletRequest request, HttpServletResponse response)
    {
        // JSONObject result=new JSONObject();
        DecimalFormat df = new DecimalFormat("0.00");
        ModelAndView mv=new ModelAndView();
        String room_id=request.getParameter("room_id");
        String factory=request.getParameter("factory");
        roomModel room=rs.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList()).get(0);
        room.setOwn(gs.selbyid(room.getApartment_id()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList()).get(0).getOwner());
        mv.addObject("room",room);
        // result.put("msg1",user);
//        if(room_id.endsWith("0")) {
//            List<yqModel> apparatus0 = ys.selbyRid(room_id);
//            mv.addObject("room")
//          //  result.put("msg2",apparatus0);
//          //  result.put("resule","10013");
//        }
//        else
//        {
        if(room_id.endsWith("0")==false) {
            List<yqModel> apparatus1 = ys.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
//            for (int i = 0; i < apparatus1.size(); i++) {
//                List<apdataModel> apdataModels = ads.selbyid(apparatus1.get(i).getId());
//                if (apdataModels.size() == 0) {
//                    apparatus1.get(i).setTotel("0");
//                } else {
//                    double sum1 = 0;
//                    for (int j = 0; j < apdataModels.size(); j++) {
//                        sum1 = sum1 + Double.parseDouble(apdataModels.get(j).getValue());
//                    }
//                    apparatus1.get(i).setTotel(df.format(sum1));
//                }
//            }
            mv.addObject("apparatus1",apparatus1);
        }
        StringBuilder a=new StringBuilder(room_id);
        a.setCharAt(4, '0');
        List<yqModel> apparatus0 = ys.selbyRid(a.toString()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
//        for(int k=0;k<apparatus0.size();k++)
//        {
//            List<apdataModel> apdataModels=ads.selbyid(apparatus0.get(k).getId());
//            if(apdataModels.size()==0)
//            {apparatus0.get(k).setTotel("0");}
//            else {
//                double sum0=0;
//                for (int l = 0; l < apdataModels.size(); l++) {
//                    sum0 = Double.parseDouble(apdataModels.get(l).getValue()) + sum0;
//                }
//                apparatus0.get(k).setTotel(df.format(sum0));
//            }
//        }
        mv.addObject("apparatus0",apparatus0);
        mv.setViewName("applicance_state");
        return mv;
        // result.put("msg2",apparatus1);
        // result.put("msg3",apparatus0);
        // }
        // HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //APP接口
    @RequestMapping("/onoff")
    public void httpURLConectionGET1(int actionID,HttpServletRequest request, HttpServletResponse response) {
        String id=request.getParameter("id");
        String user_telephone=request.getParameter("user_telephone");
        //String factory=us.selbytel(user_telephone).getFactory();
        JSONObject result=new JSONObject();
        String a="0";
        try {
            //String username=us.selbytel(user_telephone).getUser_name();
            yqModel yq=ys.selbyid(id);
            String apparatus_id=yq.getApparatus_id();
            String useable=yq.getUseable();
            if(useable.equals(a)&&actionID==2)
            {
                try {
                   // System.out.println(apparatus_id);
                    //System.out.println(useable);
                    URL url = new URL("http://ss1.chakonger.net.cn/web/action?actionID=2&inst=0&token="+apparatus_id+"");    // 把字符串转换为URL请求地址
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();// 打开连接
                    connection.connect();// 连接会话
                    // 获取输入流
                    BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
                    String line;
                    StringBuilder sb = new StringBuilder();
                    while ((line = br.readLine()) != null) {// 循环读取流
                        sb.append(line);
                    }
                    br.close();// 关闭流
                    connection.disconnect();// 断开连接
                    System.out.println(sb.toString());
                    String msg0=sb.toString();
                    JSONObject json= JSON.parseObject(msg0);
                    String b=json.getString("devStatus");
                    if(b.equals("A003")||b.equals("A004")||b.equals("A005"))
                    {
                        ys.upbyid(user_telephone,id);
                        ApModel am=new ApModel();
                        am.setApparatus_id(id);
                        DateUtil dateUtil=new DateUtil();
                        am.setTime(dateUtil.getTime());
                        am.setUser_name_on(user_telephone);
                        am.setFactory(us.selbytel(user_telephone).getFactory());
                        as.add(am);
                        result.put("msg","10001");
                    }
                    else if(b.equals("A002"))
                    {
                        result.put("msg","插控儿没有连接上wifi");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("失败!");
                }

            }
            else
            {
                if(useable.equals(user_telephone)&&actionID==0)
                {
                    try {
                        URL url = new URL("http://ss1.chakonger.net.cn/web/action?actionID=0&inst=0&token="+apparatus_id+"");    // 把字符串转换为URL请求地址
                        HttpURLConnection connection = (HttpURLConnection) url.openConnection();// 打开连接
                        connection.connect();// 连接会话
                        // 获取输入流
                        BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
                        String line;
                        StringBuilder sb = new StringBuilder();
                        while ((line = br.readLine()) != null) {// 循环读取流
                            sb.append(line);
                        }
                        br.close();// 关闭流
                        connection.disconnect();// 断开连接
                        System.out.println(sb.toString());
                        JSONObject json= JSON.parseObject(sb.toString());
                        String b=json.getString("devStatus");
                        if(b.equals("A003")||b.equals("A004")||b.equals("A005"))
                        {
                            ys.upbyid(a,id);
                            ApModel am=new ApModel();
                            am.setApparatus_id(id);
                            DateUtil dateUtil=new DateUtil();
                            am.setTime(dateUtil.getTime());
                            am.setUser_name_off(user_telephone);
                            am.setFactory(us.selbytel(user_telephone).getFactory());
                            as.add(am);
                            result.put("msg","10002");
                        }
                        else if(b.equals("A002"))
                        {
                            result.put("msg","插控儿没有连接上wifi");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("失败!");
                    }
                    }
                else
                {
                    result.put("msg","10003");
                }
            }
        }
        catch(Exception e)
        {
            result.put("msg",e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    public static HttpURLConnection connection(String URL
    ) throws Exception {
        URL url = new URL(URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoOutput(true);
        connection.setDoInput(true);
        connection.setRequestMethod("POST");
        connection.setUseCaches(false);
        connection.setInstanceFollowRedirects(true);
        connection.setRequestProperty("Content-Type",
                "application/x-www-form-urlencoded;charset=UTF-8");
        connection.connect();
        return connection;
        // TODO Auto-generated method stub
    }
    //APP接口
    @RequestMapping("PowerAndValue")
    public void PoweAndValue(HttpServletResponse response,HttpServletRequest request)
    {
        JSONObject result=new JSONObject();
        String user_telephone=request.getParameter("user_telephone");
        String factory=us.selbytel(user_telephone).getFactory();
        if(user_telephone.equals("false"))
        {
            result.put("msg","fail");
        }
        else {
            String room_id = ur.selbyUtel(user_telephone).get(ur.selbyUtel(user_telephone).size() - 1).getRoom_id();
            List<yqModel> apparatus1 = ys.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            StringBuilder a = new StringBuilder(room_id);
            a.setCharAt(4, '0');
            List<yqModel> apparatus0 = ys.selbyRid(a.toString()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            List<EleModel> eleModels1=new ArrayList<EleModel>();
            List<EleModel> eleModels0=new ArrayList<EleModel>();
            DecimalFormat df = new DecimalFormat("0.00");
            for(int i=0;i<apparatus1.size();i++)
            {
                EleModel e=new EleModel();
                e.setYq(apparatus1.get(i));
                double sum = 0.00;
                List<apdataModel> apdata1 = ads.getdv0(user_telephone,apparatus1.get(i).getId());
                if(apdata1.size()==0){}
                else {
                    for (int j = 0; j < apdata1.size(); j++) {
                        sum = sum + Double.parseDouble(apdata1.get(j).getValue());
                    }
                }
                    e.setSum(df.format(sum));
                    e.setApdata(apdata1);
                    eleModels1.add(e);
            }
            for(int i=0;i<apparatus0.size();i++)
            {
                EleModel e=new EleModel();
                e.setYq(apparatus0.get(i));
                List<apdataModel> apdata1 = ads.getdv0(user_telephone, apparatus0.get(i).getId());
                System.out.println(apdata1.size());
                double sum = 0.00;
                if(apdata1.size()==0){}
                else {
                    for (int j = 0; j < apdata1.size(); j++) {
                        sum = sum + Double.parseDouble(apdata1.get(j).getValue());
                    }
                }
                    e.setSum(df.format(sum));
                    e.setApdata(apdata1);
                    eleModels0.add(e);

            }
            result.put("siyou",eleModels1);
            result.put("gongyou",eleModels0);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/Statistic")
    public void Statistic(HttpServletResponse response,HttpServletRequest request)
    {
        double sum1=0.00;
        double sum2=0.00;
        double sum3=0.00;
        double sum4=0.00;
        double sum5=0.00;
        DecimalFormat df = new DecimalFormat("0.00");
        JSONObject result=new JSONObject();
        String date_start=request.getParameter("date_start");
        String date_end=request.getParameter("date_end");
        String room_id=request.getParameter("room_id");
        String user_telephone = request.getParameter("user_telephone");
        String factory=us.selbytel(user_telephone).getFactory();
        //私有区域总用电量
        List<yqModel> yqModels = ys.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
        for(int j=0;j<yqModels.size();j++) {
            String apparatus_id = yqModels.get(j).getId();
            List<apdataModel> apdataModels = ads.getbyid(apparatus_id);
            if(apdataModels.size()==0)
            {}
            else {
                while (true) {
                    if (apdataModels.get(0).getTime().equals(date_start) == false) {
                        apdataModels.remove(apdataModels.get(0));
                        if(apdataModels.size()==0)
                        {
                            break;
                        }
                    } else {
                        break;
                    }
                }
                if(apdataModels.size()!=0) {
                    while (true) {
                        if (apdataModels.get(apdataModels.size() - 1).getTime().equals(date_end) == false) {
                            apdataModels.remove(apdataModels.get(apdataModels.size() - 1));
                            if (apdataModels.size() == 0) {
                                break;
                            }
                        } else {
                            break;
                        }
                    }
                }
                if(apdataModels.size()==0){}
                else {
                    for (int i = 0; i < apdataModels.size(); i++) {
                        sum1 = sum1 + Double.parseDouble(apdataModels.get(i).getValue());
                    }
                }
            }
        }
        StringBuilder a = new StringBuilder(room_id);
        a.setCharAt(4, '0');
        List<yqModel> apparatus0 = ys.selbyRid(a.toString()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());

        //公有区域总用电量（个人）
        for(int j=0;j<apparatus0.size();j++) {
            String apparatus_id = apparatus0.get(j).getId();
            List<apdataModel> apdataModels = ads.getdv0(user_telephone,apparatus_id);
            if(apdataModels.size()==0)
            {}
            else {
                while (true) {
                    if (apdataModels.get(0).getTime().equals(date_start) == false) {
                        apdataModels.remove(apdataModels.get(0));
                        if(apdataModels.size()==0)
                        {
                            break;
                        }
                    } else {
                        break;
                    }
                }
                if(apdataModels.size()!=0) {
                    while (true) {
                        if (apdataModels.get(apdataModels.size() - 1).getTime().equals(date_end) == false) {
                            apdataModels.remove(apdataModels.get(apdataModels.size() - 1));
                            if (apdataModels.size() == 0) {
                                break;
                            }
                        } else {
                            break;
                        }
                    }
                }
                if(apdataModels.size()==0){}
                else {
                    for (int i = 0; i < apdataModels.size(); i++) {
                        sum2 = sum2 + Double.parseDouble(apdataModels.get(i).getValue());
                    }
                }
            }
        }

        //个人总结用电量
        sum3=sum1+sum2;

        //公有区域总用电量（总的）
        for(int j=0;j<apparatus0.size();j++) {
            String apparatus_id = apparatus0.get(j).getId();
            List<apdataModel> apdataModels = ads.getbyid(apparatus_id);
            if(apdataModels.size()==0)
            {}
            else {
                while (true) {
                    if (apdataModels.get(0).getTime().equals(date_start) == false) {
                        apdataModels.remove(apdataModels.get(0));
                        if(apdataModels.size()==0)
                        {
                            break;
                        }
                    } else {
                        break;
                    }
                }
                if(apdataModels.size()!=0) {
                    while (true) {
                        if (apdataModels.get(apdataModels.size() - 1).getTime().equals(date_end) == false) {
                            apdataModels.remove(apdataModels.get(apdataModels.size() - 1));
                            if (apdataModels.size() == 0) {
                                break;
                            }
                        } else {
                            break;
                        }
                    }
                }
                if(apdataModels.size()==0){}
                else {
                    for (int i = 0; i < apdataModels.size(); i++) {
                        sum4 = sum4 + Double.parseDouble(apdataModels.get(i).getValue());
                    }
                }
            }
        }
        //公寓总用电量
        roomModel room=rs.selbyRid(room_id).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList()).get(0);
        List<roomModel> roomModels = rs.selbyAid(room.getApartment_id()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
        for(int i=0;i<roomModels.size();i++) {
            List<yqModel> yqModels1 = ys.selbyRid(roomModels.get(i).getRoom_id()).stream().filter(k->k.getFactory().equals(factory)).collect(Collectors.toList());
            if (yqModels1.size() == 0) {
            } else {
                for (int j = 0; j < yqModels1.size(); j++) {
                    String apparatus_id = yqModels1.get(j).getId();
                    List<apdataModel> apdataModels = ads.getbyid(apparatus_id);
                    if (apdataModels.size() == 0) {
                    } else {
                        while (true) {
                            if (apdataModels.get(0).getTime().equals(date_start) == false) {
                                apdataModels.remove(apdataModels.get(0));
                                if (apdataModels.size() == 0) {
                                    break;
                                }
                            } else {
                                break;
                            }
                        }
                        if(apdataModels.size()!=0) {
                        while (true) {
                            if (apdataModels.get(apdataModels.size() - 1).getTime().equals(date_end) == false) {
                                apdataModels.remove(apdataModels.get(apdataModels.size() - 1));
                                if (apdataModels.size() == 0) {
                                    break;
                                }
                            } else {
                                break;
                            }
                        }
                        }
                        if (apdataModels.size() == 0) {
                        } else {
                            for (int k = 0; k < apdataModels.size(); k++) {
                                sum5 = sum5 + Double.parseDouble(apdataModels.get(k).getValue());
                            }
                        }
                    }
                }
            }
        }
        result.put("sum1",df.format(sum1));
        result.put("sum2",df.format(sum2));
        result.put("sum3",df.format(sum3));
        result.put("sum4",df.format(sum4));
        result.put("sum5",df.format(sum5));
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    //APP接口
    @RequestMapping("updateBeizhu")
    public void updateBeizhu(HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String beizhu=request.getParameter("beizhu");
        String id=request.getParameter("id");
        try {
            boolean b=ys.updateBeizhu(beizhu,id);
            if(b)
            result.put("msg","更新成功");
            else {
            result.put("msg","更新失败");}
        }
        catch (Exception r)
        {result.put("msg","更新失败");}
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
//    @RequestMapping("/add")
//    public void add(HttpServletResponse response,yqModel a)
//    {
//        JSONObject result=new JSONObject();
//        try {
//            boolean b= ys.add(a);
//            if (b) {
//                result.put("msg", "存储成功");
//            }
//        } catch (Exception e) {
//            result.put("msg1", e);
//            result.put("msg2", "参数错误添加失败");
//        }
//        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
//    }
}
