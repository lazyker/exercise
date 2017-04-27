package com.cozel.intranet.admin.vo;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class ConsultantVo {

    private String userId;

    @NotNull(message = "신청자를 입력해주세요.")
    @NotEmpty(message = "신청자를 입력해주세요.")
    private String userName;


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}
