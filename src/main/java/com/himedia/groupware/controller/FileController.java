package com.himedia.groupware.controller;


import com.himedia.groupware.dto.FileDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.FileService;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

@Controller
public class FileController {

    @Autowired
    FileService fs;

    @GetMapping("/fileMain")
    public String fileMain(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if(loginUser != null){
            url = "work/fileMain";
            result = fs.selectFile(request);
            model.addAttribute("fileList", result.get("fileList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key",  result.get("key"));
        }
        return url;
    }

    @GetMapping("/fileInsertForm")
    public String fileInsertForm() {return "work/fileInsertForm";}

    @PostMapping("/insertFile")
    public String insertFile(@Valid @ModelAttribute("dto") FileDto filedto, BindingResult result, Model model) {
        String url = "work/fileInsertForm";
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else{
            url = "redirect:/fileMain";
            fs.insert(filedto);
        }
        model.addAttribute("dto", filedto);
        return url;
    }

    @GetMapping("/selectfile")
    public String selectfile(){return "work/selectfile";}

    @PostMapping("/fileinsert")
    public String fileinsert(@RequestParam("originalname")MultipartFile file,
                             HttpServletRequest request, Model model){
        String path = request.getServletContext().getRealPath("/files");

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

        model.addAttribute("originalname", filename); // 또는 sanitize 처리
        model.addAttribute("savedname", savefilename);
        return "work/filecomplete";

    }

    @GetMapping("/deleteFile")
    public String deleteFile(@RequestParam("id")int id){
        fs.delete(id);
        return "redirect:/fileMain";
    }




}
