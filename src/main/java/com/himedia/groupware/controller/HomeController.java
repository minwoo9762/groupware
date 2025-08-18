package com.himedia.groupware.controller;

import com.himedia.groupware.dto.AttendanceDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.AttendanceService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @Autowired
    AttendanceService atds;

    @GetMapping("/home")
    public String home(AttendanceDto atddao, HttpSession session, Model model) {
        String url = "redirect:/";
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        if(udto != null) {
            url = "index";

            model.addAttribute("loginUser", udto);

            AttendanceDto confirmAtd = atds.selectAttendance(udto.getEmail());
            if(confirmAtd != null) model.addAttribute("confirmAtd", confirmAtd);

        }
        return url;
    }

    @PostMapping("/addAttendance")
    public String attendance(@RequestBody AttendanceDto atddao, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/login";
        if(udto != null) {

            if(atddao.getIndate() != null) atds.insertAttendance(atddao, udto.getEmail());
            else atds.updateAttendance(atddao, udto.getEmail());

            url = "index";
        }
        return url;
    }

}
