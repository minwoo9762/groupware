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

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
            if (confirmAtd != null) {
                Timestamp indate = confirmAtd.getIndate();
                Timestamp outdate = confirmAtd.getOutdate();

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String startOnly = (indate != null) ? sdf.format(indate) : null;  // null 체크
                String endOnly = (outdate != null) ? sdf.format(outdate) : null;    // null 체크
                String today = sdf.format(new Date());  // 오늘 날짜

                System.out.println(confirmAtd);
                System.out.println(startOnly);
                System.out.println(endOnly);
                System.out.println(today);

                // 1. 오늘 출석 O, 오늘 퇴근 O
                if (startOnly != null && startOnly.equals(today) && endOnly != null && endOnly.equals(today)) {
                    model.addAttribute("indateTrue", 0);  // 출석 버튼 비활성화
                    model.addAttribute("outdateTrue", 0); // 퇴근 버튼 비활성화
                }

                // 2. 오늘 출석 O, 오늘 퇴근 X
                else if (startOnly != null && startOnly.equals(today) && (endOnly == null || !endOnly.equals(today))) {
                    model.addAttribute("indateTrue", 0);  // 출석 버튼 비활성화
                    model.addAttribute("outdateTrue", 1); // 퇴근 버튼 활성화
                }

                // 3. 오늘 출석 X, 오늘 퇴근 X
                else if (startOnly == null || !startOnly.equals(today) && (endOnly == null || !endOnly.equals(today))) {
                    model.addAttribute("indateTrue", 1);  // 출석 버튼 활성화
                    model.addAttribute("outdateTrue", 0);  // 퇴근 버튼 비활성화
                }

                // 4. 오늘 출석 X 오늘 퇴근 O
                else if (startOnly == null || !startOnly.equals(today) && (endOnly == null || endOnly.equals(today))) {
                    model.addAttribute("indateTrue", 0);  // 출석 버튼 비활성화
                    model.addAttribute("outdateTrue", 0);  // 퇴근 버튼 비활성화
                }
            }


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
