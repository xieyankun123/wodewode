package com.xyk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xyk.model.apdataModel;
import com.xyk.model.yqModel;
import com.xyk.service.apdataService;
import com.xyk.service.yqService;
import com.xyk.util.DateUtil;
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
    private yqService ys;
    @Scheduled(cron = "0 * * * * ?")
    public void test1()
    {
            List<yqModel> yqmodels=ys.list();
            for(int i=0;i<yqmodels.size();i++)
            {
            //每个一段时间你想要做的事
            //连接服务器
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
                        am.setDevID(yqmodels.get(i).getDevID());
                        String dat = date.getTime();
                        am.setTime(dat);
                        String val = js.getString("socketOut_W");
                        am.setValue(val);
                        as.add(am);
                    }
                }
                else
                {
                    System.out.println("无效的仪器");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

//    Timer timer = new Timer();
//    Tools t=new Tools();
//    Date startDate=t.str2Date("2018-10-16 19:00:00");
//       timer.scheduleAtFixedRate(new TimerTask() {
//        @Override
//        public void run() {
//            //每个一段时间你想要做的事
//            //连接服务器
//            try{
//                apdataModel am=new apdataModel();
//                HttpURLConnection connection = connection("http://ss1.chakonger.net.cn/web/deviceqry");
//                DataOutputStream out = new DataOutputStream(
//                        connection.getOutputStream());
//                JSONObject obj = new JSONObject();
//                obj.put("sessionID",
//                        "ce4904e06ee1cb2b63d66dd695be94d0feebceb7201b0e4d94a8172b90cd9ca1c492ab2c6ae9324c2ce45e");
//                obj.put("devID", "31151223520625525638");
//                // 向腾讯请求传入编码为UTF-8格式的json数据
//                out.write(obj.toString().getBytes("UTF-8"));
//                out.flush();
//                out.close();
//                //获得服务器返回的结果
//                BufferedReader reader = new BufferedReader(new InputStreamReader(
//                        connection.getInputStream()));
//                String lines;
//                StringBuffer sb = new StringBuffer();
//                while ((lines = reader.readLine()) != null) {
//                    sb.append(lines);
//                }
//                reader.close();
//                connection.disconnect(); // 销毁连接
//                JSONObject js=JSON.parseObject(sb.toString());
//                DateUtil date=new DateUtil();
//                String dat=date.getTime();
//                am.setDevID("31151223520625525638");
//                am.setTime(dat);
//                String val=js.getString("socketOut_W");
//                am.setValue(val);
//                as.add(am);
//            }catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }, startDate, 3*60*1000);//开始时间Date型，周期long型豪秒级
}
