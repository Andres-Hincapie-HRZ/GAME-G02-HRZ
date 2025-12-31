package com.go2super.service;

import com.go2super.resources.ResourceManager;
import lombok.SneakyThrows;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;

@Service
public class EmailService {

    private JavaMailSender emailSender;

    @Autowired
    public EmailService(JavaMailSender javaMailSender) {
        this.emailSender = javaMailSender;
    }

    @SneakyThrows
    public String sendOTP(String email) {

        String otp = RandomStringUtils.randomNumeric(4);

        MimeMessage mimeMessage = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

        String htmlMsg = ResourceManager.getOtpHtml().replaceAll("\\{otp}", otp);
        helper.setText(htmlMsg, true);
        helper.setTo(email);
        helper.setSubject("SuperGO2 - Validation Code");
        helper.setFrom("master@supergo2.com");

        emailSender.send(mimeMessage);
        return otp;

    }

}
