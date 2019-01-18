package com.xyk.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xyk.dao.AddJackDao;
import com.xyk.model.AddJackModel;
import com.xyk.model.addByUserModel;
import com.xyk.model.managerModel;
import com.xyk.model.yqModel;
import com.xyk.service.AddJackService;
import com.xyk.util.Cons;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static com.xyk.controller.yqController.connection;

@Controller
@RequestMapping("/anu")
public class addID {
    @Resource
    private AddJackService abs;
    private final static String URL = "http://ss1.chakonger.net.cn/web/devicelist";
    private final static String URL1 = "http://ss1.chakonger.net.cn/web/login";
    private static String str;
    private static String md5;
    private static List<AddJackModel> list;

    @RequestMapping("/adm")
    public void getmessage(HttpServletResponse response,HttpServletRequest request, yqModel a,AddJackModel b) {
        JSONObject result=new JSONObject();

        request.getParameter("id");
        request.getParameter("sessionID");
        request.getParameter("devID");
        request.getParameter("apparatus_id");
        request.getParameter("beizhu");
        request.getParameter("useable");
        request.getParameter("room_id");
        a.setYonghuming("13141323884");
        a.setMima("chakong3884");
        a.setBeizhu2(request.getParameter("beizhu"));
       managerModel attribute = (managerModel) request.getSession().getAttribute(Cons.MANAGER);
        a.setFactory(attribute.getFactory());
        boolean INSERT_FLAG = abs.add(a);
        result.put("msg",INSERT_FLAG);
        abs.add_2(b);
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }

    @RequestMapping("/res")
    public String getadd(HttpServletResponse response){
        JSONObject result=new JSONObject();
        result.put("newAdd",list);
        PrintWriter pw = null;
        String data=result.toString();
        addmet(response, pw, data);
        return null;
    }

    private void addmet(HttpServletResponse response, PrintWriter pw, String data) {
        try {
            pw = response.getWriter();
            pw.write(data);
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            pw.close();
        }
    }

    @RequestMapping("/dev")
    public void candid(HttpServletResponse response) {
        addDev();
        JSONObject result=new JSONObject();

        result.put("newAdd",list);
        System.out.println(list);
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));

    }


    public void addDev() {
        int flag1 = 0;
        int flag2 = 0;
        String sr = getId(str);
        System.out.println(sr);

        // 连接服务器
        try {

            HttpURLConnection connection = connection(URL);
            DataOutputStream out = new DataOutputStream(connection.getOutputStream());

            JSONObject obj = new JSONObject();
            obj.put("sessionID", sr);
            obj.put("devicelist", "[]");
            // System.out.println(obj.toString());

            // 请求传入编码为UTF-8格式的json数据
            out.write(obj.toString().getBytes("UTF-8"));
            out.flush();
            out.close();
            // 获得服务器返回的结果
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String lines;
            StringBuffer sb = new StringBuffer("");
            while ((lines = reader.readLine()) != null) {
                lines = new String(lines.getBytes(), "utf-8");
                sb.append(lines);
            }
            reader.close();
            connection.disconnect(); // 销毁连接

            JSONObject js = JSON.parseObject(sb.toString());
            String js1 = js.getString("device");
            com.alibaba.fastjson.JSONArray js2 = JSON.parseArray(js1);

            list = new ArrayList<AddJackModel>();

            for (int i = 0; i < js2.size(); i++) {
                //System.out.println(js2.getJSONObject(i).getString("token"));
                String js3 = js2.getJSONObject(i).getString("token");
                String js4 = js2.getJSONObject(i).getString("devID");


                List<AddJackModel> m = abs.selSessionId(sr);

                //存入sessionID
                if (m.size()==0) {
                    flag1 = 1;
                    System.out.println("zhengque666");

                    abs.add_1(sr);
                } else {
                    flag1 = 0;

                }
                //存入token和devID
                List<AddJackModel> mm = abs.selDevId(js4);
                //System.out.println(mm+"shenmegui");
                    if(mm.size()==0){
                        flag2 = 1;
                        String apparatus_id = js3;
                        String devID = js4;
                        System.out.println(js3 + " " + js4);
                        AddJackModel user = new AddJackModel(apparatus_id, devID);
                        list.add(user);
                    }else{
                        flag2 = 0;
                    }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println(flag1+"+"+flag2);

    }

    //得到sessionID
    public static String getId(String str) {
        //连接服务器
        try{
            String md = MD5(str);
            HttpURLConnection connection = connection(URL1);

            DataOutputStream out = new DataOutputStream(
                    connection.getOutputStream());

            JSONObject obj = new JSONObject();

            obj.put("userName",
                    "13141323884");

            obj.put("passWord",md);
            //打印username和password
            //System.out.println(obj.toString());

            //请求传入编码为UTF-8格式的json数据
            out.write(obj.toString().getBytes("UTF-8"));
            out.flush();
            out.close();
            //获得服务器返回的结果
            BufferedReader reader = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String lines;
            StringBuffer sb = new StringBuffer("");
            while ((lines = reader.readLine()) != null) {
                lines = new String(lines.getBytes(), "utf-8");
                sb.append(lines);
            }
            reader.close();
            connection.disconnect(); // 销毁连接
            //String str =sb.toString();
            JSONObject js = JSON.parseObject(sb.toString());
            if(js.getString("sessionID") != null) {
                //System.out.println(js.getString("sessionID"));
                str = js.getString("sessionID");
            }else {
                System.out.println(sb.toString());
            }

        }catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }

    public static void setStr(String str) {
        addID.str = str;
    }

    //MD5加密用户密码
    public static String MD5(String str) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        // spring自带工具包DigestUtils
        md5 = DigestUtils.md5DigestAsHex("chakong3884".getBytes());
        return md5;
    }
    
}