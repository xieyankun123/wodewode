package com.wxm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;

import com.wxm.model.LolaModel;
import com.wxm.service.ILolaService;
import com.wxm.util.HttpOutUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/lolamanagement.req")
public class lolaController {

    @Resource
    private ILolaService iLolaService;

    private static final Logger logger = LoggerFactory.getLogger(lolaController.class.getName());


    @RequestMapping(method = {RequestMethod.POST},params = "action=getLola")
    public void getLola(HttpServletRequest request, HttpServletResponse response) {
        String taskId = (String)request.getParameter("task_id");
        logger.info("请求数据的任务id是" + taskId );
        try {
            List<LolaModel> list = iLolaService.getLolaByTaskId(taskId);
            String jsonData = JSON.toJSONString(list, true);
            HttpOutUtil.outData(response,jsonData);
        } catch (Exception e) {
            logger.error("controller出现异常：{}", e);
        }
    }

}
