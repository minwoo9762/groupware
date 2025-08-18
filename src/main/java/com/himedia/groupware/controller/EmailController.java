package com.himedia.groupware.controller;


import com.himedia.groupware.dto.EmailDto;
import com.himedia.groupware.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailservice;



    @GetMapping("/writeEmail")
    public String sendEmail(@RequestBody EmailDto emaildto) {
        emailservice.sendEmail(emaildto.getEmail(), emaildto.getContent());

        return "/email/workEmailWrite";
    }

}
