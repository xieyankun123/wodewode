package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.event.ActionEvent;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
@Controller
@RequestMapping("chakong")
public class chakongController {
    @RequestMapping("/onoff")
    public void httpURLConectionGET1(int actionID,HttpServletRequest request, HttpServletResponse response) {
       String token=request.getParameter("token");
       System.out.println(token);
       System.out.println(actionID);
        try {
            URL url = new URL("http://ss1.chakonger.net.cn/web/action?actionID="+actionID+"&inst=0&token="+token+"");    // 把字符串转换为URL请求地址
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
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("失败!");
        }
    }
}
