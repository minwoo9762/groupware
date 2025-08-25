package com.himedia.groupware.controller;

import com.himedia.groupware.dto.MailDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.MailService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class MailController {
    @Autowired
    private MailService ms;

    @GetMapping("/mail")
    public String mail(HttpSession session, Model model) {
        String url = "/user/loginForm";
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        HashMap<String, Object> result;
        if(loginUser!=null){
            result = ms.getRecentMail(loginUser.getId());
            model.addAttribute("sendList", result.get("sendList"));
            model.addAttribute("receiveList", result.get("receiveList"));
            url = "mail/mailMain";
        }
        return url;
    }
    @GetMapping("/inbox")
    public String inbox(HttpServletRequest request, Model model) {
        String url = "/user/loginForm";
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        HashMap<String, Object> result;
        if(loginUser!=null){

        }
        return url;
    }
}
