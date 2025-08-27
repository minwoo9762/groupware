package com.himedia.groupware.controller;

import com.himedia.groupware.dto.AsInfoDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.dto.WorkBoardDto;
import com.himedia.groupware.service.AdminService;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class WorkController {


    @Autowired
    WorkBoardService bs;

    @Autowired
    ServletContext context;

    @Autowired
    AdminService abs;

    ArrayList<AsInfoDto> providerList;
    ArrayList<AsInfoDto> partList;
    ArrayList<AsInfoDto> stateList;



    @GetMapping("/workBoard")
    public String boardList(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if (loginUser != null) {
            url = "work/workBoard";
            result = bs.selectBoard(request);
            partList = abs.getPart();
            model.addAttribute("partList", partList);
            model.addAttribute("boardList", result.get("boardList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return url;
    }

    @GetMapping("boardView")
    public ModelAndView boardView(@RequestParam("id") int id){
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = bs.getBoard(id);
       partList = abs.getPart();
        mav.addObject("partList", partList);
        mav.addObject("board", result.get("board"));
        mav.addObject("replyList", result.get("replyList"));
        mav.setViewName("work/workBoardView");
        return mav;
    }

    @GetMapping("/boardWrite")
    public String boardWrite(Model model){
        partList = abs.getPart();
        model.addAttribute("partList", partList);
        return "work/workBoardWrite";
    }

    @GetMapping("/selectimg")
    public String selectimg() {
        return "work/selectimg";
    }

    @PostMapping("/fileupload")
    public String fileupload(@RequestParam("image") MultipartFile file,
                             HttpServletRequest request, Model model) {
        String path = request.getServletContext().getRealPath("/images");

        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs(); // 디렉토리 없으면 생성
        }

        String filename = file.getOriginalFilename();
        if (filename == null || filename.isEmpty()) {
            model.addAttribute("error", "파일명이 비어 있습니다.");
            return "errorPage"; // 예외 처리 뷰
        }

        int dotIndex = filename.lastIndexOf(".");
        String fn1 = (dotIndex != -1) ? filename.substring(0, dotIndex) : filename;
        String fn2 = (dotIndex != -1) ? filename.substring(dotIndex) : "";

        long t = System.currentTimeMillis();
        String savefilename = fn1 + t + fn2;

        String uploadPath = path + "/" + savefilename;
        try {
            file.transferTo(new File(uploadPath));
        } catch (IOException | IllegalStateException e) {
            e.printStackTrace();
            model.addAttribute("error", "파일 업로드 실패: " + e.getMessage());
            return "errorPage";
        }

        model.addAttribute("image", filename); // 또는 sanitize 처리
        model.addAttribute("savefilename", savefilename);
        return "work/completeUpload";
    }

    @PostMapping("/writeBoard")
    public String writeBoard(@Valid @ModelAttribute("dto") WorkBoardDto boarddto, BindingResult result, Model model) {
        String url = "/work/workBoardWrite";
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if(result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else{

            url="redirect:/workBoard";
            bs.insert(boarddto);

        }
        partList = abs.getPart();
        model.addAttribute("partList", partList);
        model.addAttribute("dto", boarddto);
        return url;
    }

    @GetMapping("/boardViewWithoutCnt")
    public ModelAndView boardViewWithoutCnt(@RequestParam("id") int id) {
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = bs.getBoardWithoutCnt(id);
        mav.addObject("board", result.get("board"));
        mav.addObject("replyList", result.get("replyList"));
        mav.setViewName("work/workBoardView");
        return mav;
    }

    @GetMapping("/updateBoardForm")
    public ModelAndView updateBoardForm(@RequestParam("id") int id) {
        ModelAndView mav = new ModelAndView();
        partList = abs.getPart();
        mav.addObject("partList", partList);
        mav.addObject("dto", bs.getBoardOne(id));
        mav.addObject("oldfilename",bs.getBoardOne(id).getSavefilename());
        mav.setViewName("work/updateBoard");
        return mav;
    }




    @PostMapping("/updateBoard")
    public String updateBoard(@ModelAttribute("dto") @Valid WorkBoardDto boarddto, BindingResult result,
                              @RequestParam("oldfilename") String oldfilename, Model model){
        model.addAttribute("oldfilename", oldfilename);
        String url="work/updateBoard";
//        WorkBoardDto bdto = bs.getBoardOne(boarddto.getId());

        if (result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if (result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else{
            url="redirect:/boardViewWithoutCnt?id="+ boarddto.getId();
            bs.update(boarddto);
        }
        partList = abs.getPart();
        model.addAttribute("partList", partList);
        return url;
    }

    @GetMapping("/deleteBoard")
    public String deleteBoard(@RequestParam("id") int id) {
        bs.delete(id);
        return "redirect:/workBoard";
    }




}
