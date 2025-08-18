package com.himedia.groupware.controller;

import com.himedia.groupware.dto.WorkBoardDto;
import com.himedia.groupware.service.WorkBoardService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class WorkController {

    @Autowired
    WorkBoardService bs;

    @GetMapping("/")
    public String mainPage (){return "mainTest";}

    @GetMapping("/email")
    public String email() {return "/email/workEmail";}

    @GetMapping("workBoard")
    public ModelAndView workBoard(HttpServletRequest request) {
        HashMap<String,Object> result = new HashMap<>();
        result = bs.selectBoard(request);
        ArrayList<WorkBoardDto> list = (ArrayList<WorkBoardDto>) result.get("BoardList");

        ModelAndView mav = new ModelAndView();
        mav.addObject("boardList", list);
        mav.setViewName("/work/workBoard");
        System.out.println((result));
        System.out.println((mav));
        return mav;
    }

     @GetMapping("/workBoardWrite")
    public String workBoardWrite(){return "work/workBoardWrite";}
}
