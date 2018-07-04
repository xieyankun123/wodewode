package com.wxm.service.impl;

import com.wxm.dao.TransactionDao;
import com.wxm.service.ItransactionService;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Connection;

@Service
public class transactionService implements ItransactionService {

    @Resource
    private TransactionDao transactionDao;

    @Override
    public void update(String from, String to, String money) throws DataAccessException {

        transactionDao.sub(from,money);

        transactionDao.plus(to,money);
    }
}
