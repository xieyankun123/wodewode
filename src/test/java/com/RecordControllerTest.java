package com;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.junit.Test;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import static org.junit.Assert.*;

public class RecordControllerTest {

    @Test
    public void power1(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        BufferedReader br=new BufferedReader(new InputStreamReader(request.getInputStream()));
        String line;
        StringBuffer sb=new StringBuffer();
        while((line=br.readLine())!=null)
        {
            sb.append(line);
        }
        JSONObject js=JSONObject.parseObject(sb.toString());
        String js1=js.getString("msg");
        JSONArray ja=JSONObject.parseArray(js1);
        System.out.println(ja.size());
        for(int i=0;i<ja.size();i++)
        {
            System.out.println(ja.get(i));
        }
    }
}