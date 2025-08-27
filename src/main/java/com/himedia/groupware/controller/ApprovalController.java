package com.himedia.groupware.controller;

import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.AsInfoDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.dto.WorkBoardDto;
import com.himedia.groupware.service.AdminService;
import com.himedia.groupware.service.ApprovalService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class ApprovalController {


    @Autowired
    ApprovalService as;

    @Autowired
    AdminService abs;

    ArrayList<AsInfoDto> providerList;
    ArrayList<AsInfoDto> partList;
    ArrayList<AsInfoDto> stateList;

    @GetMapping("/appMain")
    public String appMain(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if (loginUser != null) {
            url = "approval/approvalMain";
            result = as.selectApp(request);
            partList = abs.getPart();
            model.addAttribute("partList", partList);
            model.addAttribute("appList", result.get("appList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }

        return url;
    }


    @GetMapping("/appView")
    public ModelAndView appView(@RequestParam("id") int id, HttpSession session, Model model){
        UserDto udto = (UserDto) session.getAttribute("loginUser");
        ModelAndView mav = new ModelAndView();

        HashMap<String, Object> result = as.getApp(id);
        partList = abs.getPart();
        providerList = abs.getProvider();
        mav.addObject("providerList", providerList);
        mav.addObject("partList", partList);
        mav.addObject("app", result.get("app"));
        mav.addObject("replyList", result.get("replyList"));
        mav.setViewName("approval/approvalView");

        model.addAttribute("loginUser", udto);
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
        partList = abs.getPart();
        model.addAttribute("partList", partList);
        model.addAttribute("dto", approvaldto);
        return url;
    }


    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam int id, @RequestParam int status) {
        as.updateStatus(id, status);
        System.out.println("redirect:/appView?id=" + id);
        return "redirect:/appView?id=" + id;
    }








    @PostMapping("/ajaxViewDate")
    public String ajaxViewDate(@RequestBody ApprovalDto approvaldto, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 1) {
                url = "approval/approvalView";
                as.ajaxViewDate(approvaldto);
                model.addAttribute("data", approvaldto);
            }
        }
        return url;
    }
}
