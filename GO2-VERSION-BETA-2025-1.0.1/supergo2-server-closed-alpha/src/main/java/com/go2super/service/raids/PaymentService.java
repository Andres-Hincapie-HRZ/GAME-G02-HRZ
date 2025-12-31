package com.go2super.service.raids;

import com.fasterxml.jackson.databind.JsonNode;
import com.go2super.dto.payment.XsollaUserInfoDTO;
import com.go2super.dto.payment.sub.UserInformationDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

@Service
public class PaymentService {

    public PaymentService() {

    }

    public ResponseEntity paymentXsolla(JsonNode body, HttpServletRequest request) {

        System.out.println(body.toPrettyString());
        System.out.println(request);

        UserInformationDTO userInformationDTO = UserInformationDTO.builder()
                .id(0)
                .name("ToxicSSJ")
                .level("5")
                .build();

        XsollaUserInfoDTO xsollaUserInfoDTO = XsollaUserInfoDTO.builder()
                .status("success")
                .user(userInformationDTO)
                .build();

        return ResponseEntity.ok(xsollaUserInfoDTO);

    }

}
