package com.himedia.groupware.controller;

import com.himedia.groupware.dto.AttendanceDto;
import com.himedia.groupware.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class HomeController {

    @Autowired
    AttendanceService atds;

    @GetMapping("/home")
    public String home() {
        return "index";
    }

    @PostMapping("/attendance2")
    public String attendance(@RequestBody AttendanceDto atddao) {
        System.out.println(atddao);
        atds.insertAttendance(atddao);
        return "index";
    }

}
