package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.factory;
import com.xyk.model.gyModel;
import com.xyk.model.managerModel;
import com.xyk.service.factoryService;
import com.xyk.service.gyService;
import com.xyk.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
    private factoryService fservice;
        @Resource
        private gyService gyservice;
        @RequestMapping("testlist")
        public JSONObject lis()
        {
            JSONObject r=new JSONObject();
            List<gyModel> list = gyservice.list();
            r.put("msg",list);
            return r;
        }
        @RequestMapping("apa_list")
        public ModelAndView list(HttpServletResponse response,HttpServletRequest request)
        {
            ModelAndView modelAndView = new ModelAndView();
            List<gyModel> a = gyservice.list();
            List<factory> list = fservice.list();
            managerModel managerModel = (managerModel)request.getSession().getAttribute(Cons.MANAGER);
            if(managerModel.getFactory().equals("0"))
            {
                modelAndView.addObject("apalist",a);
            }
            else {
                List<gyModel> c = a.stream()
                        .filter(b -> b.getFactory().equals(managerModel.getFactory()))
                        .collect(Collectors.toList());
                //将返回给页面的数据放入模型和视图对象中
                modelAndView.addObject("apalist", c);
            }
            modelAndView.addObject("factorylist",list);
            //指定返回的页面位置
            modelAndView.setViewName("apa_list");
            return modelAndView;
        }
    public String get32UUID(){
        return UuidUtil.get32UUID();
    }
        @RequestMapping("/add")
        public void add(gyModel g,HttpServletResponse response,HttpServletRequest request)
        {
            JSONObject result = new JSONObject();
            result.put("result", "10001");
            String encoderContent=get32UUID();
            g.setApartment_id(encoderContent);
            gyservice.add(g);
            try {
                String pic= "uploadpic/head_pic/";
		/*String encoderContent = "Hello 大大、小小,welcome to QRCode!"
				+ "\nMyblog [ http://sjsky.iteye.com ]"
				+ "\nEMail [ sjsky007@gmail.com ]";*/
                String filename =encoderContent+".png" ;
                String imgPath = PathUtil.getClasspath() + pic + filename;
                TwoDimensionCode.encoderQRCode(encoderContent, imgPath, "png");//执行生成二维码
            } catch (Exception e) {
            System.out.println("chucuole");
            }
            HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        }
        //解析二维码
        @RequestMapping("/readTD")
        @ResponseBody
        public JSONObject readTD(HttpServletRequest request)
        {
            String c=request.getParameter("latitude");
            System.out.println(c);
            JSONObject result = new JSONObject();
            try {
                String filePath = PathUtil.getClasspath() +c;  //存放路径
                String readContent = TwoDimensionCode.decoderQRCode(filePath);//执行读取二维码
                if(readContent==null)
                    result.put("result","无法解析");
                else {
                    result.put("result", readContent);
                }
            } catch (Exception e) {
                result.put("result","出现异常");
            }
            finally {
                return result;
            }
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

