package com.xyk.Interceptor;

import java.net.InetAddress;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
/**
 * @description 利用spring框架提供的HandlerInterceptorAdapter，实现自定义拦截器
 */
public class UserLoginInterceptorBySpring extends HandlerInterceptorAdapter{
    // 在业务处理器处理请求之前被调用
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        // equalsIgnoreCase 与 equals的区别？
        if("GET".equalsIgnoreCase(request.getMethod())){
            //RequestUtil.saveRequest();
        }

        String requestUri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String url = requestUri.substring(contextPath.length());
        String username = (String) request.getSession().getAttribute("manager_telephone");
        if(null == username){
            if(url.equals("/mg/checkCode")||url.equals("/mg/login"))
            {return true;
            }
            else {
                // 跳转到登录页面 请求转发
                request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
                return false;
            }
        }
        else{
            if (request.getRequestURI().equals("/mg/index")) {
                HttpSession a = request.getSession();
                String ip = "";
                if (request.getHeader("x-forwarded-for") == null) {
                    ip = request.getRemoteAddr();
                } else {
                    ip = request.getHeader("x-forwarded-for");
                }
                System.out.println(a.getAttribute("manager_telephone") + "在" + new Date() + "登陆了" + "ip为" + ip);
            }
            return true;
        }
    }
    // 在业务处理器处理请求完成之后，生成视图之前执行
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }
    // 在DispatcherServlet完全处理完请求之后被调用，可用于清理资源
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception{
    }
}

