package com.himedia.groupware.controller;

import com.himedia.groupware.dto.*;
import com.himedia.groupware.service.HomeServiece;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class HrController {

    @Autowired
    private HrService hs;
    @Autowired
    HomeServiece homes;

    @GetMapping("/attendance")
    public String attendance(@RequestParam("aseq") int aseq, Model model, HttpSession session, HttpServletRequest request) {
        Object loginUser = request.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/";
        }

        UserDto udto = (UserDto)session.getAttribute("loginUser");
        List<AttendanceDto> attendanceList = hs.selectAttendanceByUserId(aseq);

        // 출근, 퇴근 기준 시간
        LocalTime cutoffLate = LocalTime.of(9, 30);
        LocalTime cutoffEarlyLeave = LocalTime.of(18, 30);

        int lateCount = 0;
        int absentCount = 0;
        int earlyLeaveCount = 0;
        int vacationCount = 0;

        for (AttendanceDto att : attendanceList) {
            Timestamp indate = att.getIndate();
            Timestamp outdate = att.getOutdate();

            // 휴가 상태
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

            // 지각 여부
            if (inTime.isAfter(cutoffLate)) {
                att.setState(1);
                lateCount++;
            } else {
                att.setState(0);
            }

            if (outdate != null) {
                LocalTime outTime = outdate.toLocalDateTime().toLocalTime();
                // 조퇴 여부
                if (outTime.isBefore(cutoffEarlyLeave)) {
                    att.setState(4);
                    earlyLeaveCount++;
                }
            }
        }

        // 잔여 휴가 계산 (15일 고정)
        int totalVacationDays = 15;
        int remainingVacation = totalVacationDays - vacationCount;

        String userid = attendanceList.isEmpty() ? "" : attendanceList.get(0).getUserid();

        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("aseq", aseq);
        model.addAttribute("userid", userid);
        model.addAttribute("lateCount", lateCount);
        model.addAttribute("absentCount", absentCount);
        model.addAttribute("earlyLeaveCount", earlyLeaveCount);
        model.addAttribute("vacationCount", vacationCount);
        model.addAttribute("remainingVacation", remainingVacation);

        ArrayList<ApprovalDto> vacationList = homes.getVCT(udto.getId());
        model.addAttribute("vacation", vacationList);

        System.out.println("vacationList size: " + vacationList.size());

        return "attendance/attendance";
    }

    @GetMapping("/vacation")
    public String vacation(HttpServletRequest request, Model model) {
        if(request.getSession().getAttribute("loginUser") == null) {
            return "redirect:/";
        }

        HashMap<String, Object> result = hs.selectVacation(request);

        model.addAttribute("vacationList", result.get("vacationList"));
        model.addAttribute("paging", result.get("paging"));
        model.addAttribute("key", result.get("key"));

        return "vacation/vacation";
    }

    @GetMapping("/vacationDetail")
    public String vacationDetail(@RequestParam("pseq") int pseq, Model model, HttpServletRequest request) {
        if(request.getSession().getAttribute("loginUser") == null) {
            return "redirect:/";
        }

        VacationDto vdto = hs.getVacation(pseq);
        model.addAttribute("vacationDetail", vdto);

        return "vacation/vacationDetail";
    }

    @GetMapping("/paycheck")
    public String paycheck(HttpServletRequest request, Model model) {
        HashMap<String, Object> result = hs.selectPay(request);

        model.addAttribute("payList", result.get("payList"));
        model.addAttribute("paging", result.get("paging"));
        model.addAttribute("key", result.get("key"));

        return "pay/payCheckList";
    }

    @GetMapping("/payDetail")
    public String payDetail(@RequestParam("pseq") int pseq, Model model, HttpServletRequest request) {
        if(request.getSession().getAttribute("loginUser") == null) {
            return "redirect:/";
        }

        PayDto pdto = hs.getPay(pseq);
        model.addAttribute("payDetail", pdto);

        return "pay/payDetail";
    }
}