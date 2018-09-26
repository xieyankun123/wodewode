package com.xyk.dao;

import java.util.List;

import javax.annotation.Resource;

import com.xyk.model.LolaModel;
import com.xyk.service.ILolaService;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class LolaDaoTest {

   @Resource
   ILolaService iLolaService;

   @Test
   public void testDao(){
      System.out.println("test start");
      List<LolaModel> list = iLolaService.getLolaByTaskId("000000133663089602017112217551");
      System.out.println(list.get(0).getJd());
      System.out.println("test end");
   }
   
}
