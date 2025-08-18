package com.himedia.groupware.controller;

import com.himedia.groupware.dto.AttendanceDto;
import com.himedia.groupware.dto.VacationDto;
import com.himedia.groupware.service.HrService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;

@Controller
public class HrController {

    @Autowired
    HrService hs;

    @GetMapping("/home")
    public String home() {
        return "index";
    }


    @GetMapping("/attendance")
    public String attendance(@RequestParam("id") int id, Model model) {
        List<AttendanceDto> attendanceList = hs.getAttendanceListByUserId(id);

        // 출근 퇴근 기준 시간
        LocalTime cutoffLate = LocalTime.of(9, 30);
        LocalTime cutoffEarlyLeave = LocalTime.of(18, 30);

        int lateCount = 0;
        int absentCount = 0;
        int earlyLeaveCount = 0;
        int vacationCount = 0;

        for (AttendanceDto att : attendanceList) {
            Timestamp indate = att.getIndate();
            Timestamp outdate = att.getOutdate();

            // 휴가
            if (att.getState() == 5) {
                vacationCount++;
                continue;
            }

            // 결석
            if (indate == null) {
                att.setState(2);
                absentCount++;
                continue;
            }

            LocalTime inTime = indate.toLocalDateTime().toLocalTime();

            // 지각
            if (inTime.isAfter(cutoffLate)) {
                att.setState(1);
                lateCount++;
            } else {
                att.setState(0);
            }

            if (outdate != null) {
                LocalTime outTime = outdate.toLocalDateTime().toLocalTime();

                // 조퇴
                if (outTime.isBefore(cutoffEarlyLeave)) {
                    att.setState(4);
                    earlyLeaveCount++;
                }
            }
        }

        // 잔여 휴가 계산
        int totalVacationDays = 15;  // 15일로 가정
        int remainingVacation = totalVacationDays - vacationCount;

        String userid = "";
        if(!attendanceList.isEmpty()){
            userid = attendanceList.get(0).getUserid();
        }

        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("id", id);
        model.addAttribute("userid", userid);
        model.addAttribute("lateCount", lateCount);
        model.addAttribute("absentCount", absentCount);
        model.addAttribute("earlyLeaveCount", earlyLeaveCount);
        model.addAttribute("vacationCount", vacationCount);
        model.addAttribute("remainingVacation", remainingVacation);

        return "/Hr/attendance";
    }

    @GetMapping("/vacationList")
    public String vacationList(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        VacationDto loginVacation = (VacationDto) session.getAttribute("loginVacation");
        HashMap<String, Object> result = null;

        return "/Hr/vacation";
    }

    @GetMapping("/paycheck")
    public String paycheck(Model model) {

        return "/Hr/paycheck";
    }

}
