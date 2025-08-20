package com.himedia.groupware.controller;

import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.ApprovalService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
        ApprovalDto adto = as.getAppList();
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if (loginUser != null) {
            url = "approval/approvalMain";
            result = as.selectApp(request);
            model.addAttribute("appList", result.get("appList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("appKey", result.get("appKey"));
        }

        String[] partList = {"", "1부서", "2부서", "3부서"};
        String [] categoryList = {"휴가", "영수증", "법인차량"};
        String [] statusList = {"결재요청", "결재중", "결재완료"};
        model.addAttribute("partName", partList[loginUser.getPart()]);
        model.addAttribute("categoryName", categoryList[adto.getCategory()]);
        model.addAttribute("statusName", statusList[adto.getStatus()]);

        return url;
    }

    @GetMapping("/appView")
    public ModelAndView approvalView(@RequestParam("id") int id){
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = as.getApp(id);
        mav.addObject("app", result.get("app"));
        mav.addObject("replyList", result.get("replyList"));
        mav.setViewName("approval/approvalView");
        return mav;
    }

    @GetMapping("/appWrite")
    public String boardWrite(){
        return "approval/approvalWrite";
    }

//    @PostMapping("/insertApp")




}
