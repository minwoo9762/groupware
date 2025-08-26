package com.himedia.groupware.controller;

import com.himedia.groupware.dto.*;
import com.himedia.groupware.service.AdminService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.apache.catalina.User;
import com.himedia.groupware.dto.NoticeDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
            if (udto.getProvider() == 1) {
                url = "admin/admin";

                HashMap<String, Object> result = ads.getUser(request);
                model.addAttribute("userList", result.get("userList"));
                model.addAttribute("paging", result.get("paging"));
                model.addAttribute("key", result.get("key"));

                ArrayList<AsInfoDto> providerList = ads.getProvider();
                ArrayList<AsInfoDto> partList = ads.getPart();
                ArrayList<AsInfoDto> stateList = ads.getState();

                model.addAttribute("providerList", providerList);
                model.addAttribute("partList", partList);
                model.addAttribute("stateList", stateList);
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
            if (udto.getProvider() == 1) {
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
            if (udto.getProvider() == 1) {

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
            if (udto.getProvider() == 1) {
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
            if (udto.getProvider() == 1) {
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
    public String noticeWrite(@Valid @ModelAttribute("dto") NoticeDto noticedto,
            HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 1) {
                url = "admin/noticeWrite";
                ads.selectNoticeInfo(udto);
                model.addAttribute("user", udto);
            }
        }


        return url;
    }


    @PostMapping("/noticeWriteInsert")
    public String noticeWriteInsert(@Valid @ModelAttribute("dto") NoticeDto noticedto,
                                    BindingResult result,
                                    HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/";
        if(udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 1) {

                if(result.hasFieldErrors("title"))
                    model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
                else if(result.hasFieldErrors("content"))
                    model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
                else{

                    url = "redirect:/notice?first=y";

                    ads.insertNotice(noticedto);
                }
                model.addAttribute("msg", "작성완료.");
                model.addAttribute("dto", noticedto);

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
            if (udto.getProvider() == 1) {
                url = "redirect:/admin";
                ads.updateNotice(noticedto);
            }
        }
        return url;
    }
    @Autowired
    ServletContext context;

    @PostMapping("/adminFileup")
    public String adminFileup(@RequestParam("image") MultipartFile file,
                                               HttpServletRequest request, Model model) {
        String path = request.getServletContext().getRealPath("/images");

        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs(); // 디렉토리 없으면 생성
        }

        String filename = file.getOriginalFilename();
        if (filename == null || filename.isEmpty()) {
            model.addAttribute("error", "파일명이 비어 있습니다.");
            return ""; // 예외 처리 뷰
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
            return "";
        }

        model.addAttribute("image", filename); // 또는 sanitize 처리
        model.addAttribute("savefilename", savefilename);
        return "admin/noticeComplete";
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

    public ModelAndView noticeUpdateForm(@RequestParam("nseq") int nseq) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("dto", ads.getNoticeOne(nseq));
        mav.addObject("oldfilename",ads.getNoticeOne(nseq).getSavefilename());
        mav.setViewName("admin/noticeUpdate");
        return mav;
    }

    @PostMapping("/noticeUpdate")
    public String updateBoard(@ModelAttribute("dto") @Valid NoticeDto noticedto, BindingResult result,
                              @RequestParam("oldfilename") String oldfilename, Model model){
        model.addAttribute("oldfilename", oldfilename);
        String url="admin/noticeUpdate";
//        WorkBoardDto bdto = bs.getBoardOne(boarddto.getId());

        if (result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage());
        else if (result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage());
        else{
            url="redirect:/noticeDetail?nseq="+ noticedto.getNseq();
            ads.update(noticedto);
        }
        return url;
    }

    @GetMapping("/noticeimg")
    public String noticeimg() {
        return "admin/noticeimg";
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
            if (udto.getProvider() == 1) {
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
                    model.addAttribute("title", "부서");
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
            @RequestParam(value = "insert", required = false, defaultValue ="false") boolean insert,
            @RequestParam("id") int[] ids,
            @RequestParam("name") String[] names,
            HttpSession session) {

        UserDto udto = (UserDto) session.getAttribute("loginUser");
        String url = "redirect:/";
        if (udto != null) {
            url = "redirect:/alert";
            if (udto.getProvider() == 1) {

                if(tabid == 1) {
                    url = "redirect:/allInfoCtr?tabid=1";

                    if(insert) {
                        for(int i=0; i<ids.length; i++) {
                            ads.insertProvider(ids[i], names[i]);
                        }
                    }

                    for(int i=0; i<ids.length; i++) {
                        ads.replaceProvider(ids[i], names[i]);
                    }
                }
                if(tabid == 2) {
                    url = "redirect:/allInfoCtr?tabid=2";

                    if(insert) {
                        for(int i=0; i<ids.length; i++) {
                            ads.insertPart(ids[i], names[i]);
                        }
                    }

                    for(int i=0; i<ids.length; i++) {
                        ads.replacePart(ids[i], names[i]);
                    }
                }
                if(tabid == 3) {
                    url = "redirect:/allInfoCtr?tabid=3";

                    if(insert) {
                        for(int i=0; i<ids.length; i++) {
                            ads.insertState(ids[i], names[i]);
                        }
                    }

                    for(int i=0; i<ids.length; i++) {
                        ads.replaceState(ids[i], names[i]);
                    }
                }

            }
        }

        return url;
    }

}


