package com.himedia.groupware.controller;

import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.UserDto;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class WorkController {


    @Autowired
    WorkBoardService bs;

    @Autowired
    ServletContext context;

    @GetMapping("/workBoard")
    public String boardList(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if (loginUser != null) {
            url = "work/workBoard";
            result = bs.selectBoard(request);
            model.addAttribute("boardList", result.get("boardList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }

        String[] partList = {"", "1부서", "2부서", "3부서"};
        String[] providerList = {"관리자", "사원"};
        model.addAttribute("partName", partList[loginUser.getPart()]);
        //  model.addAttribute("providerName", providerList[userdto.getProvider()]);

        return url;
    }

    @GetMapping("boardView")
    public ModelAndView boardView(@RequestParam("id") int id){
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = bs.getBoard(id);
        mav.addObject("board", result.get("board"));
        mav.addObject("replyList", result.get("replyList"));
        System.out.println(result.get("board"));
        mav.setViewName("work/workBoardView");
        return mav;
    }

    @GetMapping("/boardWrite")
    public String boardWrite(){
        return "work/workBoardWrite";
    }

    @GetMapping("/selectimg")
    public String selectimg() {
        return "work/selectimg";
    }

    @PostMapping("/fileupload")
    public String fileupload(@RequestParam("image") MultipartFile file,
                             HttpServletRequest request, Model model) {
        String path = context.getRealPath("/images");
        String filename = file.getOriginalFilename();
        Calendar today = Calendar.getInstance();
        long t = today.getTimeInMillis();
        String fn1 = filename.substring(0, filename.indexOf(".")); //abc.jsp -> abc
        String fn2 = filename.substring(filename.indexOf(".")); //abc.jsp -> .jsp
        String savefilename = fn1 + t + fn2; //abc1234567.jsp
        String uploadPath = path + "/"+ savefilename; //저장경로/abc1234567.jsp
        try{
            file.transferTo(new File(uploadPath)); //파일 업로드
        } catch (IOException e) {
            throw new RuntimeException(e);
        }catch (IllegalStateException e) {
            e.printStackTrace();
        }
        model.addAttribute("image", filename);
        model.addAttribute("savefilename", savefilename);
        return "work/completeUpload";

    }


    @PostMapping("/writeBoard")
    public String writeBoard(@Valid @ModelAttribute("dto") WorkBoardDto boarddto, BindingResult result, Model model) {
        System.out.println("Image: " + boarddto.getImage());
        System.out.println("SaveFilename: " + boarddto.getSavefilename());
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
        WorkBoardDto bdto = bs.getBoardOne(boarddto.getId());


        if (result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if (result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else{
            System.out.println(boarddto.getId());
            url="redirect:/boardViewWithoutCnt?id="+ boarddto.getId();
            bs.update(boarddto);
        }
        return url;
    }

    @GetMapping("/deleteBoard")
    public String deleteBoard(@RequestParam("id") int id) {
        bs.delete(id);
        return "redirect:/workBoard";
    }




}
