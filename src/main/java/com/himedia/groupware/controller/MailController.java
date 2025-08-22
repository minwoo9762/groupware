package com.himedia.groupware.controller;

import com.himedia.groupware.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class MailController {
    @Autowired
    private MailService ms;
}
