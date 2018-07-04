package com.wxm.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author xinmao.wxm
 */

@Controller
@RequestMapping("/ImageManagement.req")
public class SkinImageController {

    private HashMap<String, File> imageClassificationResult = new HashMap<>();

    @RequestMapping(method = {RequestMethod.POST}, params = "action=uploadImage")
    public void uploadImage(@Param("file") MultipartFile image, HttpServletRequest request) {

        String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/"
            + image.getOriginalFilename();

        // 转存文件
        File tmpFile = new File(filePath);

        try {
            image.transferTo(tmpFile);
        } catch (IOException e) {
            e.printStackTrace();
        }

        imageClassificationResult.put(image.getName(), tmpFile);
    }
}




