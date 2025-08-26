package com.himedia.groupware.controller;

import com.himedia.groupware.dto.InfoDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.InfoService;
import com.himedia.groupware.service.MyPageService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MyPageController {
    @Autowired
    MyPageService ms;
    @Autowired
    InfoService is;

    @GetMapping("/myPage")
    public String myPage(HttpSession session, Model model) {
        session.getAttribute("loginUser");
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");

        String url = "redirect:/";
        if (loginUser != null) {
            InfoDto idto = is.getInfo(loginUser.getId());
            model.addAttribute("info", idto);
            url = "myPage/profile";
        }
        return url;
    }

    @GetMapping("/updateProfileForm")
    public String updateProfile(HttpSession session, Model model) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        String url = "redirect:/";
        if(loginUser != null){
            model.addAttribute("dto", loginUser);
            InfoDto idto = is.getInfo(loginUser.getId());
            model.addAttribute("info", idto);
            model.addAttribute("oldImage", loginUser.getProfileimg());
            url = "myPage/updateProfileForm";
        }
        return url;
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute("dto") @Valid UserDto userdto, BindingResult result,
                                HttpSession session, Model model) {
        String url = "myPage/updateProfileForm";
        InfoDto idto = is.getInfo(userdto.getId());
        model.addAttribute("info", idto);
        if (result.hasFieldErrors("name"))
            model.addAttribute("message", "이름을 입력하세요.");
        else if (result.hasFieldErrors("phone"))
            model.addAttribute("message", "전화번호를 입력하세요.");
        else if (result.hasFieldErrors("address1") || result.hasFieldErrors("address2"))
            model.addAttribute("message", "주소를 입력하세요.");
        else {
            ms.updateUser(userdto);
            session.setAttribute("loginUser", userdto);
            url = "redirect:/myPage";
        }
        return url;
    }

    @GetMapping("/changePwd")
    public String changePwd(HttpSession session, Model model) {
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        return "myPage/changePwd";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
        session.removeAttribute("loginUser");
        return "redirect:/";
    }
}
