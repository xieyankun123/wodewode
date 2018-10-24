package com.xyk.controller;

import com.alibaba.fastjson.JSONObject;
import com.xyk.model.ExcelBean;
import com.xyk.model.UserModel;
import com.xyk.model.addByUserModel;
import com.xyk.service.addByUserService;
import com.xyk.service.userService;
import com.xyk.util.ExcelUtil;
import com.xyk.util.HttpOutUtil;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

@Controller
@RequestMapping("/user")
public class userController {
    @Resource
    private userService userservice;
    @Resource
    private addByUserService abs;
    @RequestMapping("/user_list")
    public ModelAndView list(HttpServletResponse response) {
//      List<UserModel> a=userservice.list();
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        result.put("aaa",a);
//        result.put("result","10003");
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        List<UserModel> a = userservice.list();
        ModelAndView modelAndView = new ModelAndView();
        //将返回给页面的数据放入模型和视图对象中
        modelAndView.addObject("userList", a);
        //指定返回的页面位置
        modelAndView.setViewName("user_list");
        return modelAndView;
    }

    @RequestMapping("/del")
    public String del(HttpServletRequest request, HttpServletResponse response) {
//        JSONObject result = new JSONObject();
//        result.put("result", "10001");
//        boolean a=userservice.del(id);
//        if(a==true)
//        {
//            result.put("success","删除成功");
//            result.put("result","10004");
//        }
//        else
//        {   result.put("false","删除失败");
//            result.put("result","10005");
//        }
//        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
        String b = request.getParameter("user_telephone");
        userservice.del(b);
        return "redirect:/user/";
    }

    @RequestMapping("/update")
    public void update(UserModel userModel, HttpServletRequest request, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        try {
            boolean a = userservice.update(userModel);
            if (a) {
                result.put("msg", "更新成功");
            } else {
                result.put("msg", "更新失败，没有此用户");
            }
        } catch (Exception e) {
            result.put("msg2", "缺失参数");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    @RequestMapping("/weixinLogin")
    public void weixinLogin(HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String user_weixin=request.getParameter("user_weixin");
        List<UserModel> a=userservice.selbystate("1");
        result.put("msg",false);
        for(int i=0;i<a.size();i++) {
            if(a.get(i).getUser_weixin().isEmpty()==false) {
                if (a.get(i).getUser_weixin().equals(user_weixin)) {
                    String user_telephone = a.get(i).getUser_telephone();
                    result.put("msg", user_telephone);
                    break;
                }
            }
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    @RequestMapping("/selectbystate")
    public void selbystate(HttpServletRequest request, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        String user_telephone=request.getParameter("user_telephone");
        String user_weixin=request.getParameter("user_weixin");
        List<UserModel> a=userservice.selbystate("1");
        result.put("msg",false);
        boolean flag1 = false;
        boolean flag2 = false;
        for(int i=0;i<a.size();i++)
        {
            boolean b=a.get(i).getUser_telephone().equals(user_telephone);
            if(b)
            {flag1=b;
                break;
            }
            List<addByUserModel> q=abs.selbyuser(a.get(i).getUser_telephone());
            for(int j=0;j<q.size();j++)
            {
                boolean c=q.get(j).getTelephone().equals(user_telephone);
                if(c)
                {flag2=c;
                    break;
                }
            }
            if(flag2)
                break;
        }
        if(flag1||flag2)
        {
            if(flag1)
            {try{
                boolean b=userservice.addweixin(user_weixin,user_telephone);
            }
            catch (Exception e)
            {result.put("msg",e);}}
            else{}
            result.put("msg",user_telephone);
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }

    @RequestMapping("/selectTel")
    public void selbytel(HttpServletRequest request, HttpServletResponse response) {
         response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        String tel=request.getParameter("user_telephone");
        UserModel a=userservice.selbytel(tel);
        result.put("user",a);
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
//        String b = request.getParameter("user_telephone");
//        UserModel a = userservice.selbytel(b);
//        ModelAndView modelAndView = new ModelAndView();
//        //将返回给页面的数据放入模型和视图对象中
//        modelAndView.addObject("user", a);
//        //指定返回的页面位置
//        modelAndView.setViewName("edituser");
//        return modelAndView;
    }

    @RequestMapping("/add")
    public void add(UserModel userModel, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        try {
            boolean a = userservice.add(userModel);
            if (a) {
                result.put("msg", "存储成功");
            }
        } catch (Exception e) {
            result.put("msg1", e);
            result.put("msg2", "参数错误添加失败");
        }
        HttpOutUtil.outData(response, JSONObject.toJSONString(result));
    }
    //通过手机号添加微信号
    @RequestMapping("/addWeixin")
    public void addWeixin(HttpServletRequest request,HttpServletResponse response)
    {
        JSONObject result=new JSONObject();
        String user_weixin=request.getParameter("user_weixin");
        String user_telephone=request.getParameter("user_telephone");
        System.out.println(user_telephone);
        System.out.println(user_weixin);
        try{
        boolean b=userservice.addweixin(user_weixin,user_telephone);
        result.put("msg",b);
        }
        catch (Exception e)
        {
            result.put("msg",e);
        }
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
    /*
     * 导出用户信息到EXCEL
     * @return
     */
    @RequestMapping("/export")
    public void export(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<UserModel> list = userservice.list();
        List<ExcelBean> excel = new ArrayList<ExcelBean>();
        Map<Integer, List<ExcelBean>> map = new LinkedHashMap<Integer, List<ExcelBean>>();
        XSSFWorkbook xssfWorkbook = null;
        //设置标题栏
        excel.add(new ExcelBean("姓名", "user_name", 0));
        excel.add(new ExcelBean("手机号", "user_telephone", 0));
        excel.add(new ExcelBean("身份证号", "user_IDcard", 0));
        excel.add(new ExcelBean("地址", "user_address", 0));
        excel.add(new ExcelBean("性别", "user_sex", 0));
        excel.add(new ExcelBean("爱好", "user_hobby", 0));
        excel.add(new ExcelBean("地位", "user_state", 0));
        excel.add(new ExcelBean("邮件", "user_email", 0));
        excel.add(new ExcelBean("微信", "user_weixin", 0));
        map.put(0, excel);
        String sheetName = "入住人名单";
        //调用ExcelUtil的方法
        xssfWorkbook = ExcelUtil.createExcelFile(UserModel.class, list, map, sheetName);
        response.reset(); //清除buffer缓存
        // 指定下载的文件名，浏览器都会使用本地编码，即GBK，浏览器收到这个文件名后，用ISO-8859-1来解码，然后用GBK来显示
        // 所以我们用GBK解码，ISO-8859-1来编码，在浏览器那边会反过来执行。
        response.setHeader("Content-Disposition", "attachment;filename=");
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        //导出Excel对象
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            xssfWorkbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/import")
    public void impotr(HttpServletResponse response,@RequestParam(value = "file", required = false) MultipartFile file) {
        JSONObject result = new JSONObject();
        try {
            InputStream in = file.getInputStream();
            List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
            //遍历listob数据，把数据放到List中
            for (int i = 0; i < listob.size(); i++) {
                List<Object> ob = listob.get(i);
                UserModel user = new UserModel();
//            //设置编号
//            user.setSerial(SerialUtil.salarySerial());
                //通过遍历实现把每一列封装成一个model中，再把所有的model用List集合装载
                user.setUser_name(String.valueOf(ob.get(0)));
                user.setUser_telephone(String.valueOf(ob.get(1)));
                user.setUser_IDcard(String.valueOf(ob.get(2)));
                user.setUser_address(String.valueOf(ob.get(3)));
                user.setUser_sex(String.valueOf(ob.get(4)));
                user.setUser_hobby(String.valueOf(ob.get(5)));
                user.setUser_state(String.valueOf(ob.get(6)));
                //object类型转Double类型
//            salarymanage.setMoney(Double.parseDouble(ob.get(8).toString()));
                user.setUser_email(String.valueOf(ob.get(7)));
                user.setUser_weixin(String.valueOf(ob.get(8)));
                userservice.add(user);
            }
            in.close();
            result.put("msg", "插入成功");
        }
        catch(Exception e)
        {result.put("msg","插入失败,手机号码相同，或者参数不完整");}
        HttpOutUtil.outData(response,JSONObject.toJSONString(result));
    }
}

