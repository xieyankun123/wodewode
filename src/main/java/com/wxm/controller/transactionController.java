package com.wxm.controller;



import com.wxm.service.ItransactionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/transaction.req")
public class transactionController {

    @Resource
    private
    ItransactionService itransactionService;

    private final static Logger logger = LoggerFactory.getLogger(transactionController.class.getName());

    @RequestMapping(method = {RequestMethod.POST},params = "action=transaction")
    public void transactionSet(HttpServletRequest request, HttpServletResponse response){
        logger.info("start transaction");
        try{
            String fromUser = request.getParameter("from");
            String toUser = request.getParameter("to");
            String money = request.getParameter("money");

                itransactionService.update(fromUser,toUser,money);

            System.out.println("转账成功");
        }catch (Exception e){
            System.out.println("转账失败");
            logger.error("error");
        }
    }


}
