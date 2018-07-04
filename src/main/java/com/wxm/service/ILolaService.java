package com.wxm.service;

import java.util.List;

import com.wxm.model.LolaModel;

public interface ILolaService {
    List<LolaModel> getLolaByTaskId(String taskId);
}
