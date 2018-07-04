package com.wxm.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/cookies.req")
public class cookiesController {

    private final static Logger logger = LoggerFactory.getLogger(cookiesController.class.getName());

    @RequestMapping(method = {RequestMethod.POST},params = "action=cookies")
    public void cookiesSet(HttpServletRequest request, HttpServletResponse response){
        logger.info("start cookies");
        try{
            String id = "11";
            Cookie[] c = request.getCookies();

            Cookie cookie = new Cookie("ids",id);
            cookie.setPath(request.getContextPath());
            System.out.println("ContextPath"+request.getContextPath());
            System.out.println("getServletPath"+request.getServletPath());
            System.out.println("getRequestURI"+request.getRequestURI());
            System.out.println("getRequestURL"+request.getRequestURL());
            response.addCookie(cookie);


        }catch (Exception e){
            logger.error("error");
        }
    }


}
