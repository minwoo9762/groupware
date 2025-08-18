package com.himedia.groupware.controller;

import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.WorkBoardDto;
import com.himedia.groupware.service.WorkBoardService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class WorkController {

    @Autowired
    WorkBoardService bs;

    @Autowired
    ServletContext context;


    @GetMapping("workBoard")
    public ModelAndView workBoard(HttpServletRequest request) {
        HashMap<String,Object> result = new HashMap<>();
        result = bs.selectBoard(request);
        ArrayList<WorkBoardDto> list = (ArrayList<WorkBoardDto>) result.get("BoardList");
        Paging paging = (Paging)result.get("paging");

        ModelAndView mav = new ModelAndView();
        mav.addObject("boardList", list);
        mav.addObject("paging", paging);

        HttpSession session = request.getSession(false);
        if(session != null){
            Object loginUser = session.getAttribute("loginUser");
            if(loginUser != null){
                mav.addObject("loginUser", loginUser);
            }
        }
        mav.setViewName("/work/workBoard");
        return mav;
    }

    @GetMapping("boardView")
    public ModelAndView boardView(@RequestParam("id") int id){
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = bs.getBoard(id);
        mav.addObject("board", result.get("board"));
        mav.addObject("replyList", result.get("replyList"));

        mav.setViewName("/work/workBoardView");
        return mav;
    }

    @GetMapping("/boardWrite")
    public String boardWrite(){
        return "work/workBoardWrite";
    }

    @PostMapping("/writeBoard")
    public String writeBoard(@Valid @ModelAttribute("dto")WorkBoardDto boarddto, BindingResult result, Model model) {
        String url = "/work/workBoardWrite";
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if(result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else{

            url="redirect:/workBoard";
            bs.insert(boarddto);
        }
        model.addAttribute("dto", boarddto);
        return url;
    }




}
