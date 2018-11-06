package com.xyk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xyk.model.apdataModel;
import com.xyk.model.yqModel;
import com.xyk.service.apService;
import com.xyk.service.apdataService;
import com.xyk.service.yqService;
import com.xyk.util.DateUtil;
import org.omg.Messaging.SYNC_WITH_TRANSPORT;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.util.List;

import static com.xyk.controller.yqController.connection;

@Controller
@Component
public class TimerTaskController {
    @Resource
    private apdataService as;
    @Resource
    private apService apservice;
    @Resource
    private yqService ys;
    @Scheduled(cron = "0 59 23 * * ?")
    public void getValue()
    {
            List<yqModel> yqmodels=ys.list();
            for(int i=0;i<yqmodels.size();i++)
            {
                if(yqmodels.get(i).getUseable().equals("1"))
                    System.out.println("meibiyao");
            //每个一段时间你想要做的事
            //连接服务器
                else
                {
            try {
                apdataModel am = new apdataModel();
                HttpURLConnection connection = connection("http://ss1.chakonger.net.cn/web/deviceqry");
                DataOutputStream out = new DataOutputStream(
                        connection.getOutputStream());
                if(yqmodels.get(i).getDevID().matches("[0-9]{1,}") ){
                    JSONObject obj = new JSONObject();
                    obj.put("sessionID",yqmodels.get(i).getSessionID());
                    obj.put("devID", yqmodels.get(i).getDevID());
                    // 向腾讯请求传入编码为UTF-8格式的json数据
                    out.write(obj.toString().getBytes("UTF-8"));
                    out.flush();
                    out.close();
                    //获得服务器返回的结果
                    BufferedReader reader = new BufferedReader(new InputStreamReader(
                            connection.getInputStream()));
                    String lines;
                    StringBuffer sb = new StringBuffer();
                    while ((lines = reader.readLine()) != null) {
                        sb.append(lines);
                    }
                    reader.close();
                    connection.disconnect(); // 销毁连接
                    JSONObject js = JSON.parseObject(sb.toString());
                    if(js.getString("errmsg").equals("success")==false)
                        System.out.println("仪器没有连接网络");
                    else {
                        DateUtil date = new DateUtil();
                        am.setApparatus_id(yqmodels.get(i).getId());
                        String dat = date.getDay();
                        am.setTime(dat);
                        String val = js.getString("socketOut_W");
                        am.setValue(val);
                        as.add(am);
                    }
                }
                else
                {
                    //System.out.println("无效的仪器");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }}
        }
    }
    @Scheduled(cron = "0 0/2 * * * ?")
    public void getPower()
    {
        List<yqModel> yqmodels=ys.list();
        for(int i=0;i<yqmodels.size();i++) {
            //每个一段时间你想要做的事
            //连接服务器
//            if (yqmodels.get(i).getUseable().equals("0") || yqmodels.get(i).getUseable().equals("1")) {
//                System.out.println("meibiyaoceshi");
//            }
//            else {
                try {
                    apdataModel am = new apdataModel();
                    HttpURLConnection connection = connection("http://ss1.chakonger.net.cn/web/deviceqry");
                    DataOutputStream out = new DataOutputStream(
                            connection.getOutputStream());
                    if (yqmodels.get(i).getDevID().matches("[0-9]{1,}")) {
                        JSONObject obj = new JSONObject();
                        obj.put("sessionID", yqmodels.get(i).getSessionID());
                        obj.put("devID", yqmodels.get(i).getDevID());
                        // 向腾讯请求传入编码为UTF-8格式的json数据
                        out.write(obj.toString().getBytes("UTF-8"));
                        out.flush();
                        out.close();
                        //获得服务器返回的结果
                        BufferedReader reader = new BufferedReader(new InputStreamReader(
                                connection.getInputStream()));
                        String lines;
                        StringBuffer sb = new StringBuffer();
                        while ((lines = reader.readLine()) != null) {
                            sb.append(lines);
                        }
                        reader.close();
                        connection.disconnect(); // 销毁连接
                        JSONObject js = JSON.parseObject(sb.toString());
                        if (js.getString("errmsg").equals("success") == false)
                            System.out.println("仪器没有连接网络");
                        else {
                            DateUtil date = new DateUtil();
                            am.setApparatus_id(yqmodels.get(i).getId());
                            String dat = date.getTime();
                            am.setTime(dat);
                            String val = js.getString("socketOut_P");
//                            if (val.equals("0")) {
//                                //System.out.println("无效数据，丢了丢了");
//                            } else {
                                am.setValue(val);
                                String name = apservice.selbyid(yqmodels.get(i).getId()).get(apservice.selbyid(yqmodels.get(i).getId()).size() - 1).getUser_name_on();
                                am.setName(name);
                                as.addP(am);
                           // }
                        }
                    } else {
                        // System.out.println("无效的仪器");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            //}
        }
    }
}
