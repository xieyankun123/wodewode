package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.ApModel;
import com.xyk.model.gyModel;
import com.xyk.model.managerModel;
import com.xyk.service.apService;
import com.xyk.service.gyService;
import com.xyk.util.Cons;
import com.xyk.util.HttpOutUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/apartment")
public class gyController {

        @Resource
        private gyService gyservice;
        @RequestMapping("apa_list")
        public ModelAndView list(HttpServletResponse response,HttpServletRequest request)
        {
            ModelAndView modelAndView = new ModelAndView();
            List<gyModel> a = gyservice.list();
            managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
            if(managerModel.getFactory().equals("0"))
            {
                modelAndView.addObject("apalist",a);
            }
            else {
                List<gyModel> c = a.stream().filter(b -> b.getFactory().equals(managerModel.getFactory())).collect(Collectors.toList());
                //将返回给页面的数据放入模型和视图对象中
                modelAndView.addObject("apalist", c);
            }
            //指定返回的页面位置
            modelAndView.setViewName("apa_list");
            return modelAndView;
        }
        @RequestMapping("/add")
        public void add(gyModel g,HttpServletResponse response,HttpServletRequest request)
        {
            JSONObject result = new JSONObject();
            managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
            result.put("result", "10001");
            g.setFactory(managerModel.getFactory());
            gyservice.add(g);
            HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        }
        @RequestMapping("/update")
        public void update(gyModel g,HttpServletResponse response)
        {
            JSONObject result = new JSONObject();
            result.put("result", "10001");
            gyservice.update(g);
            HttpOutUtil.outData(response, JSONObject.toJSONString(result));
         }
    }

