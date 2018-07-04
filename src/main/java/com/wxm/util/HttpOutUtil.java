package com.wxm.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpOutUtil {

    /** 日志 **/
    private static final Logger LOGGER = LoggerFactory
        .getLogger(HttpOutUtil.class);

    /**
     * 向客户端输出数据。
     *
     * @param httpServletResponse
     *            响应对象
     * @param resJsonString
     */
    public static void outData(HttpServletResponse httpServletResponse,
                               String resJsonString) {
        PrintWriter writer = null;
        try {
            httpServletResponse.setContentType("application/json");
            httpServletResponse.setCharacterEncoding("utf-8");
            httpServletResponse.setHeader("Access-Control-Allow-Origin","*");
            writer = httpServletResponse.getWriter();
            writer.print(resJsonString);
            writer.flush();
        } catch (Exception e) {
            LOGGER.error("[webUtils][outData][Message]", e.getMessage());
        } finally {
            if (writer != null) {
                writer.close();
            }
        }
    }

}
