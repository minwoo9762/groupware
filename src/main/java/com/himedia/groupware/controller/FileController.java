package com.himedia.groupware.controller;


import com.himedia.groupware.dto.AsInfoDto;
import com.himedia.groupware.dto.FileDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.AdminService;
import com.himedia.groupware.service.FileService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class FileController {

    @Autowired
    FileService fs;
    @Autowired
    AdminService ads;

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

            ArrayList<AsInfoDto> partList = ads.getPart();
            model.addAttribute("partList", partList);
            model.addAttribute("loginUser", loginUser);
        }
        return url;
    }

    @GetMapping("/fileInsertForm")
    public String fileInsertForm(Model model) {
        ArrayList<AsInfoDto> partList = ads.getPart();
        model.addAttribute("partList", partList);
        return "work/fileInsertForm";}

    @GetMapping("/selectfile")
    public String selectfile(){return "work/selectfile";}

    @PostMapping("/fileInsert")
    public String fileInsert(@Valid @ModelAttribute("dto") FileDto filedto,
                             BindingResult result,
                             @RequestParam("file") MultipartFile file,
                             HttpServletRequest request,
                             Model model) {
        if (result.hasFieldErrors("title")) {
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
            return "work/fileInsertForm";
        }

        String path = request.getServletContext().getRealPath("/files");
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String filename = file.getOriginalFilename();
        if (filename == null || filename.isEmpty()) {
            model.addAttribute("error", "파일명이 비어 있습니다.");
            return "errorPage";
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

        // DB에 저장할 파일명 DTO에 세팅
        filedto.setOriginalname(filename);
        filedto.setSavedname(savefilename);

        // 파일 정보와 게시글 정보 DB에 저장 (fs.insert는 서비스 호출)
        fs.insert(filedto);

        return "redirect:/fileMain";  // 업로드 완료 후 목록으로 리다이렉트
    }

//    파일 다운로드 ---------------------------------------------------------

    @GetMapping("/filedownload")
    public void fileDownload(@RequestParam("filename") String filename,
                             HttpServletResponse response,
                             HttpServletRequest request) throws IOException {

        // webapp/files 폴더 경로 가져오기
        String uploadDir = request.getServletContext().getRealPath("/files/");
        File file = new File(uploadDir, filename);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 응답에 다운로드용 헤더 세팅
        response.setContentType("application/octet-stream");
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");

        // 파일을 response outputStream에 복사
        Files.copy(file.toPath(), response.getOutputStream());
        response.getOutputStream().flush();
    }

    @GetMapping("/deleteFile")
    public String deleteFile(@RequestParam("id")int id){
        fs.delete(id);
        return "redirect:/fileMain";
    }




}
