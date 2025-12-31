package com.go2super.service.validation;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
@Builder
public class RegisterValidation {

    private String otp;
    private Date until;

}
