package com.xyk.model;

import java.util.List;

public class EleModel {
    private yqModel yq;
    private String sum;
    private List<apdataModel> apdata;
    public yqModel getYq() {
        return yq;
    }

    public void setYq(yqModel yq) {
        this.yq = yq;
    }

    public String getSum() {
        return sum;
    }

    public void setSum(String sum) {
        this.sum = sum;
    }

    public List<apdataModel> getApdata() {
        return apdata;
    }

    public void setApdata(List<apdataModel> apdata) {
        this.apdata = apdata;
    }
}
