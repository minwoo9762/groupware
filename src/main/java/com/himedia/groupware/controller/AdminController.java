package com.himedia.groupware.controller;

import com.himedia.groupware.dto.*;
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

    @GetMapping("/alert")
    public String alert() {
        return "admin/alert";
    }

    @GetMapping("/admin")
    public String admin(HttpSession session, Model model, HttpServletRequest request) {
        String url = "redirect:/";
        UserDto udto = (UserDto) session.getAttribute("loginUser");
        if (udto != null) {
            url = "redirect:/alert";
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
            url = "redirect:/alert";
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
            url = "redirect:/alert";
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
            url = "redirect:/alert";
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
            url = "admin/notice";
            HashMap<String, Object> result = ads.getNotice(request);
            model.addAttribute("noticeList", result.get("noticeList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return url;
    }

    @GetMapping("/noticeWrite")
    public String noticeWrite(HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            url = "redirect:/alert";
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
            url = "redirect:/alert";
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
            url = "redirect:/alert";
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

            url = "admin/noticeDetail";
            NoticeDto notice = ads.selectNoticeDetail(nseq);
            model.addAttribute("notice", notice);
            model.addAttribute("name", udto.getName());

        }
        return url;
    }

    @GetMapping("/noticeUpdateForm")
    public String noticeUpdate(@RequestParam("nseq") int nseq, HttpSession session, Model model){
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 99) {
                url = "admin/noticeUpdate";
                NoticeDto notice = ads.selectNoticeDetail(nseq);
                model.addAttribute("notice", notice);
                model.addAttribute("name", udto.getName());
            }
        }
        return url;
    }

    /*부서, 팀, 상태*/
    @GetMapping("allInfoCtr")
    public String allInfoCtr(@RequestParam("tabid") int tabid,
                             @RequestParam(value = "delete", required = false, defaultValue = "false") Boolean delete,
                             @RequestParam(value = "deleteid", required = false) Integer deleteid,
                             HttpSession session, Model model){
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 99) {
                url = "admin/allInfoCtr";

                if(tabid == 1) {
                    ArrayList<AsInfoDto> providerList = ads.getProvider();
                    model.addAttribute("infoList", providerList);
                    model.addAttribute("title", "직책");
                    model.addAttribute("parms", "1");

                    if(delete) {
                        ads.userReplaceProvider(deleteid);
                        ads.deleteProvider(deleteid);
                        url = "redirect:/allInfoCtr?tabid=1";
                    }
                }

                if(tabid == 2) {
                    ArrayList<AsInfoDto> partList = ads.getPart();
                    model.addAttribute("infoList", partList);
                    model.addAttribute("title", "조직도");
                    model.addAttribute("parms", "2");

                    if(delete) {
                        ads.userReplacePart(deleteid);
                        ads.deletePart(deleteid);
                        url = "redirect:/allInfoCtr?tabid=2";
                    }
                }

                if(tabid == 3) {
                    ArrayList<AsInfoDto> stateList = ads.getState();
                    model.addAttribute("infoList", stateList);
                    model.addAttribute("title", "직원 상태");
                    model.addAttribute("parms", "3");

                    if(delete) {
                        ads.userReplaceState(deleteid);
                        ads.deleteState(deleteid);
                        url = "redirect:/allInfoCtr?tabid=3";
                    }
                }

            }
        }
        return url;
    }

    @PostMapping("allInfoCtrAction")
    public String allInfoCtrAction(
            @RequestParam("tabid") int tabid,
            @RequestParam("id") int[] ids,
            @RequestParam("name") String[] names,
            HttpSession session) {

        UserDto udto = (UserDto) session.getAttribute("loginUser");
        String url = "redirect:/";
        if (udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 99) {

                if(tabid == 1) {
                    url = "redirect:/allInfoCtr?tabid=1";
                    for(int i=0; i<ids.length; i++) {
                        ads.replaceProvider(ids[i], names[i]);
                    }
                }
                if(tabid == 2) {
                    url = "redirect:/allInfoCtr?tabid=2";
                    for(int i=0; i<ids.length; i++) {
                        ads.replacePart(ids[i], names[i]);
                    }
                }
                if(tabid == 3) {
                    url = "redirect:/allInfoCtr?tabid=3";
                    for(int i=0; i<ids.length; i++) {
                        ads.replaceState(ids[i], names[i]);
                    }
                }

            }
        }

        return url;
    }

}


