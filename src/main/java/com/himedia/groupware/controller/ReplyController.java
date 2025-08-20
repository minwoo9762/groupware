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

    @PostMapping("/addReply")
    public String addReply( ReplyDto replydto){
        rs.insert(replydto);
        return "redirect:/boardViewWithoutCnt?id="+replydto.getBoardid();
    }

    @GetMapping("/deleteReply")
    public String deleteReply(@RequestParam("id") int id, @RequestParam("boardid") int boardid ) {
        rs.delete(id);
        return "redirect:/boardViewWithoutCnt?id="+boardid;
    }

}
