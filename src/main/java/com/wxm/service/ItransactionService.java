package com.wxm.service;

import org.springframework.dao.DataAccessException;

public interface ItransactionService {

     void update(String from ,String to ,String money) throws DataAccessException;
}
