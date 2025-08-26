package com.himedia.groupware.controller;

import com.himedia.groupware.dto.AsInfoDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.AdminService;
import com.himedia.groupware.service.ExMailService;
import com.himedia.groupware.service.InfoService;
import com.himedia.groupware.service.UserService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

@Controller
public class UserController {
    @Autowired
    UserService us;
    @Autowired
    InfoService is;
    @Autowired
    ExMailService exMailService;
    private static int number;
//    @Autowired
//    AdminService ads;
//
//    ArrayList<AsInfoDto> providerList = ads.getProvider();
//    ArrayList<AsInfoDto> partList = ads.getPart();
//    ArrayList<AsInfoDto> stateList = ads.getState();


    @GetMapping("/")
    public String init() {
        return "user/loginForm";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute("dto") @Valid UserDto userdto, BindingResult result,
                        HttpSession session, Model model) {
        String url="user/loginForm";
        if (result.hasFieldErrors("email")) {
            model.addAttribute("message", "이메일을 입력하세요.");
        }else if (result.hasFieldErrors("pwd")) {
            model.addAttribute("message", "비밀번호를 입력하세요.");
        }else {
            UserDto udto = us.getUser(userdto.getEmail());
            if (udto == null)
                model.addAttribute("message", "이메일 또는 비밀번호가 다릅니다.");
            else if(!udto.getPwd().equals(userdto.getPwd()))
                model.addAttribute("message", "이메일 또는 비밀번호가 다릅니다.");
            else {
                session.setAttribute("loginUser", udto);
                url = "redirect:/home";
            }
        }
        return url;
    }

    @GetMapping("/joinForm")
    public String joinForm() {
        return "user/joinForm";
    }

    @PostMapping("/emailCheck")
    public @ResponseBody HashMap<String, Object> emailCheck(@RequestParam("email") String email) {
        HashMap<String, Object> result = new HashMap<>();
        UserDto mdto = us.getUser(email);
        if(mdto == null){
            result.put("result", "1");
        }else {
            result.put("result", "-1");
        }
        result.put("email", email);
        return result;
    }

    @PostMapping("/join")
    public String join(@ModelAttribute("dto") @Valid UserDto userdto, BindingResult result,
    @RequestParam(value="emailCheck", required=false, defaultValue = "") String emailCheck,
    @RequestParam(value="pwdCheck", required=false, defaultValue = "") String pwdCheck, Model model) {
        model.addAttribute("emailCheck", emailCheck);
        String url = "user/joinForm";
        if (result.hasFieldErrors("email"))
            model.addAttribute("message", "이메일을 입력하세요.");
        else if(!userdto.getEmail().equals(emailCheck))
            model.addAttribute("message", "이메일 중복검사를 실행하세요.");
        else if (result.hasFieldErrors("pwd"))
            model.addAttribute("message", "비밀번호를 입력하세요.");
        else if (!us.isValidPwd(userdto.getPwd()))
            model.addAttribute("message", "올바른 비밀번호를 입력하세요.");
        else if(!userdto.getPwd().equals(pwdCheck))
            model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다.");
        else if (result.hasFieldErrors("name"))
            model.addAttribute("message", "이름을 입력하세요.");
        else if (result.hasFieldErrors("phone"))
            model.addAttribute("message", "전화번호를 입력하세요.");
        else if (result.hasFieldErrors("address1"))
            model.addAttribute("message", "주소를 입력하세요.");
        else {
            us.insertUser(userdto);
            url = "user/loginForm";
            model.addAttribute("message", "가입이 완료되었습니다. 로그인하세요.");
        }
        return url;
    }

    @GetMapping("/findPwd")
    public String findPwd() {
        return "user/findPwd";
    }

    @PostMapping("/sendMailForPwd")
    @ResponseBody
    public HashMap<String, Object> sendMailForPwd(
            @RequestParam("name") String name,
            @RequestParam("email") String email) {
        HashMap<String, Object> result = new HashMap<>();
        UserDto udto = us.getUser(email);
        if(udto == null)
            result.put("findPwdMsg", "해당 아이디의 사원이 존재하지 않습니다.");
        else if(!udto.getName().equals(name))
            result.put("findPwdMsg", "해당 이름의 사원이 존재하지 않습니다.");
        else {
            number = (int)(Math.random()*90000)+100000;
            exMailService.sendMail(email, number);
            result.put("findPwdMsg", "이메일을 발송했습니다.");
            result.put("state", "sended");
        }
        return result;
    }

    @PostMapping("/confirmCode")
    @ResponseBody
    public HashMap<String, Object> confirmCode(
            @ModelAttribute("email") @RequestParam("email") String email,
            @ModelAttribute("name") @RequestParam("name") String name,
            @ModelAttribute("sendCheck") @RequestParam("sendCheck") String sendCheck,
            @ModelAttribute("code") String code){
        HashMap<String, Object> result = new HashMap<>();
        if(!sendCheck.equals("sended")) {
            result.put("codeMsg", "이메일 인증을 실행하세요.");
        }else if(code.equals(String.valueOf(number))) {
            result.put("email", email);
            result.put("state", "confirmed");
        }else {
            result.put("codeMsg", "인증번호가 일치하지 않습니다.");
            }
        return result;
    }

    @PostMapping("/updatePwd")
    public String updatePwd(@RequestParam("pwd") String pwd, @RequestParam("email") String email,
                            Model model) {
        us.updatePwd(email, pwd);
        model.addAttribute("message", "비밀번호가 변경되었습니다. 다시 로그인하세요.");
        return "user/loginForm";
    }

    @Autowired
    ServletContext context;
    @PostMapping("/fileup")
    @ResponseBody
    public HashMap<String, Object> fileup(@RequestParam("pfimg") MultipartFile file){
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
        result.put("profileimg", savefilename);
        return result;
    }

    @GetMapping("/address")
    public String address(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "user/loginForm";

        if(loginUser != null) {
            url = "user/address";
            result = us.selectAddress(request);
            model.addAttribute("userList", result.get("userList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return url;
    }

    @GetMapping("/addressWrite")
    public String addressWrite() {return "user/addressInsert";}

    @PostMapping("/addressInsert")
    public String addressInsert(@Valid @ModelAttribute("dto") UserDto userdto, Model model) {
        us.insert(userdto);
        model.addAttribute("dto", userdto);
        return "addressBook";
    }


}
