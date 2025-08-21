package com.himedia.groupware.controller;

import com.himedia.groupware.dto.ReplyDto;
import com.himedia.groupware.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReplyController {

    @Autowired
    ReplyService rs;

    @PostMapping("/addBoardReply")
    public String addBoardReply( ReplyDto replydto){
        rs.insertBoard(replydto);
        return "redirect:/boardViewWithoutCnt?id="+replydto.getBoardid();
    }

    @PostMapping("/addAppReply")
    public String addAppReply( ReplyDto replydto){
        rs.insertApp(replydto);
        return "redirect:/appView?id="+replydto.getAppid();  // 오류날 수 있음
    }

    @GetMapping("/deleteBoardReply")
    public String deleteBoardReply(@RequestParam("id") int id, @RequestParam("boardid") int boardid ) {
        rs.deleteBoard(id);
        return "redirect:/boardViewWithoutCnt?id="+boardid;
    }

    @GetMapping("/deleteAppReply")
    public String deleteAppReply(@RequestParam("id") int id, @RequestParam("appid") int appid ) {
        rs.deleteApp(id);
        return "redirect:/AppView?id="+appid;
    }

}

