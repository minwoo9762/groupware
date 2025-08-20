package com.himedia.groupware.controller;

import com.himedia.groupware.dto.NoticeDto;
import com.himedia.groupware.dto.PayDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.AdminService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

@Controller
public class AdminController {

    @Autowired
    AdminService ads;

    @GetMapping("/admin")
    public String admin(HttpSession session, Model model, HttpServletRequest request) {
        String url = "redirect:/";
        UserDto udto = (UserDto) session.getAttribute("loginUser");
        if (udto != null) {
            if (udto.getProvider() == 99) {
                url = "admin/admin";

                HashMap<String, Object> result = ads.getUser(request);
                model.addAttribute("userList", result.get("userList"));
                model.addAttribute("paging", result.get("paging"));
                model.addAttribute("key", result.get("key"));
            }
        }
        return url;
    }

    @GetMapping("/adminUserUpdate")
    public String adminUserUpdate(@ModelAttribute("dto") UserDto userdto, HttpSession session) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "redirect:/admin";
                ads.updateUser(userdto);
            }
        }
        return url;
    }

    @GetMapping("/adminPay")
    public String adminPay(@RequestParam("id") int id, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {

                UserDto user = ads.findUser(id);
                model.addAttribute("name", user.getName());
                PayDto pdto = ads.selectPay(id);
                if(pdto == null) {
                    url = "admin/adminPayForm";
                } else {
                    url = "admin/adminPayFormUpdate";
                    model.addAttribute("pdto", pdto);
                };
                model.addAttribute("id", id);
            }
        }
        return url;
    }
    @PostMapping("/adminInsertPay")
    public String adminInsertPay(@RequestBody PayDto paydto, @RequestParam("id") int id, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "redirect:/admin";

                ads.insertPay(paydto, id);
            }
        }
        return url;
    }
    @PostMapping("/adminUpdatePay")
    public String adminUpdatePay(@RequestBody PayDto paydto, @RequestParam("id") int id, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "redirect:/admin";

                ads.updatePay(paydto, id);
            }
        }
        return url;
    }





    /* @@@@@@@@@@@@ 공지사항 @@@@@@@@@@@ */
    @GetMapping("/notice")
    public String notice(HttpSession session, Model model, HttpServletRequest request ) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "admin/notice";

                HashMap<String, Object> result = ads.getNotice(request);
                model.addAttribute("noticeList", result.get("noticeList"));
                model.addAttribute("paging", result.get("paging"));
                model.addAttribute("key", result.get("key"));
            }
        }
        return url;
    }

    @GetMapping("/noticeWrite")
    public String noticeWrite(HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "admin/noticeWrite";
                ads.selectNoticeInfo(udto);
                model.addAttribute("user", udto);
            }
        }
        return url;
    }


    @PostMapping("/noticeWriteInsert")
    public String noticeWriteInsert(@RequestBody NoticeDto noticedto, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {


                url = "redirect:/admin";
                ads.insertNotice(noticedto);
                model.addAttribute("msg", "작성완료.");

            }
        }
        return url;
    }
    @PostMapping("/noticeWriteUpdate")
    public String noticeWriteUpdate(@RequestBody NoticeDto noticedto, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "redirect:/admin";
                ads.updateNotice(noticedto);
            }
        }
        return url;
    }
    @Autowired
    ServletContext context;
    @PostMapping("/adminFileup")
    @ResponseBody
    public HashMap<String, Object> adminFileup(@RequestParam("fileimage") MultipartFile file){
        String path = context.getRealPath("/images");
        Calendar today = Calendar.getInstance();
        long t = today.getTimeInMillis();
        String filename = file.getOriginalFilename();

        String fn1 = filename.substring(0, filename.indexOf("."));
        String fn2 = filename.substring(filename.indexOf("."));
        String savefilename = fn1 + t + fn2;
        String uploadPath = path + "/" + savefilename;

        try {
            file.transferTo(new File(uploadPath));
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        HashMap<String, Object> result = new HashMap<String, Object>();
        result.put("image", filename);
        result.put("savefilename", savefilename);
        return result;
    }


    @GetMapping("/noticeDetail")
    public String noticeDetail(@RequestParam("nseq") int nseq, HttpSession session, Model model){
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "admin/noticeDetail";
                NoticeDto notice = ads.selectNoticeDetail(nseq);
                model.addAttribute("notice", notice);
                model.addAttribute("name", udto.getName());
            }
        }
        return url;
    }

    @GetMapping("/noticeUpdateForm")
    public String noticeUpdate(@RequestParam("nseq") int nseq, HttpSession session, Model model){
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            if (udto.getProvider() == 99) {
                url = "admin/noticeUpdate";
                NoticeDto notice = ads.selectNoticeDetail(nseq);
                model.addAttribute("notice", notice);
                model.addAttribute("name", udto.getName());
            }
        }
        return url;
    }

}


