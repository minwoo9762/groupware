package com.himedia.groupware.controller;

import com.himedia.groupware.dto.MailDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.MailService;
import com.himedia.groupware.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class MailController {
    @Autowired
    private MailService ms;
    @Autowired
    private UserService us;

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
            url = "mail/inbox";
            result = ms.getMailList(request, "r");
            model.addAttribute("receiveList", result.get("receiveList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return url;
    }

    @GetMapping("/sent")
    public String sent(HttpServletRequest request, Model model) {
        String url = "/user/loginForm";
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        HashMap<String, Object> result;
        if(loginUser!=null){
            url = "mail/sent";
            result = ms.getMailList(request, "s");
            model.addAttribute("sendList", result.get("sendList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return url;
    }

    @GetMapping("/mailDetail")
    public String mailDetail(@RequestParam("id") int id, @RequestParam("from") String from,
                             HttpSession session, Model model) {
        String url = "/user/loginForm";
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        if(loginUser!=null) {
            MailDto mdto = ms.getMail(id);
            if(!mdto.isRead() && loginUser.getId()==mdto.getReceiverId())
                ms.setRead(id);

            int reply = mdto.getReply();
            String replyName ="";
            if(reply != 0)
                replyName = ms.getMail(reply).getSubject();

            ArrayList<MailDto> repliedList = ms.getRepliedList(id);

            model.addAttribute("mail", mdto);
            model.addAttribute("replyName", replyName);
            model.addAttribute("from", from);
            model.addAttribute("repliedList", repliedList);
            url = "mail/mailDetail";
        }
        return url;
    }

    @GetMapping("/writeMailForm")
    public String writeMailForm(HttpSession session, Model model,
            @RequestParam(value="reply", required=false, defaultValue = "0") int replyCheck) {
        String url = "/user/loginForm";
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        if(loginUser!=null) {
            String replyName = "";
            String replyUserName = "";
            if(replyCheck != 0) {
                MailDto replyMail = ms.getMail(replyCheck);
                replyName = replyMail.getSubject();
                replyUserName = replyMail.getSenderName();
            }
            model.addAttribute("replyCheck", replyCheck);
            model.addAttribute("replyName", replyName);
            model.addAttribute("replyUserName", replyUserName);
            url = "mail/writeMail";
        }
        return url;
    }

    @PostMapping("/writeMail")
    public String writeMail(@Valid @ModelAttribute("dto") MailDto maildto, BindingResult result,
        @RequestParam(value="replyCheck", required=false, defaultValue = "0") int replyCheck,
        @RequestParam(value="replyName", required=false, defaultValue = "") String replyName,
                            HttpSession session, Model model) {
        String url = "/user/loginForm";
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        model.addAttribute("replyCheck", replyCheck);
        model.addAttribute("replyName", replyName);
        if(loginUser!=null) {
            url = "mail/writeMail";
            if(result.hasFieldErrors("receiverName"))
                model.addAttribute("message", "보낼 사람을 입력하세요.");
            else if(!us.isValidName(maildto.getReceiverName()))
                model.addAttribute("message", "해당 이름의 사원이 존재하지 않습니다.");
            else if(result.hasFieldErrors("subject"))
            model.addAttribute("message", "제목을 입력하세요.");
            else if(result.hasFieldErrors("content"))
                model.addAttribute("message", "내용을 입력하세요.");
            else {
                maildto.setReceiverId(us.getUseridByName(maildto.getReceiverName()));
                maildto.setReply(replyCheck);
                ms.insertMail(maildto);
                url = "redirect:/mail";
            }
        }
        return url;
    }

    @GetMapping("/deleteMail")
    public String deleteMail(@RequestParam("id") int id) {
        ms.deleteMail(id);
        return "redirect:/mail";
    }
}
