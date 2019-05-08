package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.gyModel;
import com.xyk.model.waterrModel;
import com.xyk.service.gyService;
import com.xyk.service.meterService;
import com.xyk.service.userService;
import com.xyk.util.PathUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;
@Slf4j
@Controller
@RequestMapping("app")
public class AppController {
    @Resource
    private userService userservice;
    @Resource
    private gyService gyservice;
    @Resource
    private meterService ms;

    @RequestMapping("list")
    @ResponseBody
    public JSONObject list(@RequestParam(value = "factory",required = true)String factory)
    {
        JSONObject result=new JSONObject();
        String pic= "uploadpic/head_pic/";
        List<gyModel> list = gyservice.list().stream()
                                             .filter(b->b.getFactory().equals(factory))
                                             .collect(Collectors.toList());
        if(list.size()!=0) {
            for (int i = 0; i < list.size(); i++) {
                List<waterrModel> s = ms.s(list.get(i).getApartment_id());
                try {

                    list.get(i).setDTcode("http://139.199.82.86:8080/jieshui/" + list.get(i).getApartment_id() + ".png");
                }
                catch (Exception r)
                {
                    log.info("二维码获取错误");
                }
                if (s.size() == 0) {
                } else {
                    list.get(i).setLastValue(s.get(s.size() - 1).getValue());
                }
            }
        }
        result.put("result",list);
        return result;
    }
    @RequestMapping("updateName")
    @ResponseBody
    public JSONObject update(int id,@RequestParam(value = "owner",required = true)String owner)
    {
        JSONObject result=new JSONObject();
        boolean b = gyservice.updateName(id, owner);
         result.put("result",b);
        return result;
    }
    @RequestMapping("updateLL")
    @ResponseBody
    public JSONObject updateLL(int id,@RequestParam(value = "longitude",required = true)String longitude,@RequestParam(value = "latitude",required = true)String latitude)
    {
        JSONObject result=new JSONObject();
        boolean b = gyservice.updateLL(id, longitude,latitude);
        result.put("result",b);
        return result;
    }
}
