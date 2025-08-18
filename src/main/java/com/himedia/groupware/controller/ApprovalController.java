package com.himedia.groupware.controller;

import com.himedia.groupware.service.ApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApprovalController {

    @Autowired
    ApprovalService as;

    @GetMapping("approvalMain")
    public  String approvalMain() {
        return "approvalMain";
    }
}
