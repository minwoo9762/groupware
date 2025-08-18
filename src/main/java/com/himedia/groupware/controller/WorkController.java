package com.himedia.groupware.controller;

import com.himedia.groupware.dto.WorkBoardDto;
import com.himedia.groupware.service.WorkBoardService;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class WorkController {

    @Autowired
    WorkBoardService bs;



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

    @GetMapping("/updateBoard")
    public String updateBoard(@RequestParam("dto") @Valid WorkBoardDto workboarddto , BindingResult result,
                              Model model) {
        String url ="work/updatdBoard";
        WorkBoardDto bdto =bs.getBoardOne(workboarddto.getId());

        if(result.hasFieldErrors("pass"))
            model.addAttribute("msg", result.getFieldError("pass").getDefaultMessage());
        else if (result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if (result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else if(!workboarddto.getPass().equals(bdto.getPass()))
            model.addAttribute("msg", "수정을 위한 패스워드가 일치하지 않습니다");
        else{
            url="redirect:/boardViewWithoutCnt?num="+workboarddto.getId();
           //  bs.update(workboarddto);
    }

        return url;
    }

}
