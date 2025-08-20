package com.himedia.groupware.controller;

import com.himedia.groupware.dto.AttendanceDto;
import com.himedia.groupware.dto.NoticeDto;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.dto.VacationDto;
import com.himedia.groupware.service.AdminService;
import com.himedia.groupware.service.AttendanceService;
import com.himedia.groupware.service.HomeServiece;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;

@Controller
public class HomeController {

    @Autowired
    AttendanceService atds;
    @Autowired
    AdminService admins;
    @Autowired
    HomeServiece homes;

    @GetMapping("/home")
    public String home(AttendanceDto atddao, HttpSession session, Model model) {
        String url = "redirect:/";
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        if(udto != null) {
            url = "index";

            model.addAttribute("loginUser", udto);

            // 출석값 유무에 따른 버튼 활성화
            AttendanceDto confirmAtd = atds.selectAttendance(udto.getEmail());
            if(confirmAtd != null) model.addAttribute("confirmAtd", confirmAtd);

            // 공지사항 셀렉
            int showfiled = 5;
            ArrayList<NoticeDto> ndto = admins.currentNotice(showfiled);
            model.addAttribute("notice", ndto);

            // 달력
            ArrayList<VacationDto> vacationList = homes.getVCT(udto.getId());
            model.addAttribute("vacation", vacationList);
            
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
