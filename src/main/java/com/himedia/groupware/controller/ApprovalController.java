package com.himedia.groupware.controller;

import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.dto.WorkBoardDto;
import com.himedia.groupware.service.ApprovalService;
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
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

@Controller
public class ApprovalController {


    @Autowired
    ApprovalService as;

    @GetMapping("/appMain")
    public String appMain(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if (loginUser != null) {
            url = "approval/approvalMain";
            result = as.selectApp(request);
            model.addAttribute("appList", result.get("appList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }

        return url;
    }


    @GetMapping("/appView")
    public ModelAndView appView(@RequestParam("id") int id){
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = as.getApp(id);
        mav.addObject("app", result.get("app"));
        mav.addObject("replyList", result.get("replyList"));
        mav.setViewName("approval/approvalView");
        System.out.println("@@@@@@@@");
        System.out.println(mav);
        return mav;
    }

    @GetMapping("/appWrite")
    public String appWrite(){
        return "approval/approvalWrite";
    }

    @GetMapping("/deleteApp")
    public String deleteApp(@RequestParam("id") int id) {
        as.delete(id);
        return "redirect:/appMain";
    }
    @PostMapping("/insertApp")
    public String insertApp(@Valid @ModelAttribute("dto") ApprovalDto approvaldto, BindingResult result, Model model) {
        String url = "/approval/approvalWrite";
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if(result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else{

            url="redirect:/appMain?first=n";
            as.insert(approvaldto);
        }
        model.addAttribute("dto", approvaldto);
        return url;
    }


    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam int id, @RequestParam int status) {
        as.updateStatus(id, status);
        System.out.println("redirect:/appView?id=" + id);
        return "redirect:/appView?id=" + id;
    }







}
