package com.himedia.groupware.controller;

import com.himedia.groupware.dto.*;
import com.himedia.groupware.service.AdminService;
import com.himedia.groupware.service.AttendanceService;
import com.himedia.groupware.service.HomeServiece;
import com.himedia.groupware.service.MailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
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
    @Autowired
    MailService mails;

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
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

                // 1. 오늘 출석 O, 오늘 퇴근 O
                if (startOnly != null && startOnly.equals(today) && endOnly != null && endOnly.equals(today)) {
                    model.addAttribute("indateTrue", 0);  // 출석 버튼 비활성화
                    model.addAttribute("outdateTrue", 0); // 퇴근 버튼 비활성화
                    model.addAttribute("confirmAtd", confirmAtd);
                }

                // 2. 오늘 출석 O, 오늘 퇴근 X
                else if (startOnly != null && startOnly.equals(today) && (endOnly == null || !endOnly.equals(today))) {
                    model.addAttribute("indateTrue", 0);  // 출석 버튼 비활성화
                    model.addAttribute("outdateTrue", 1); // 퇴근 버튼 활성화
                    model.addAttribute("confirmAtd", confirmAtd);
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
            ArrayList<ApprovalDto> vacationList = homes.getVCT(udto.getId());
            model.addAttribute("vacation", vacationList);
            System.out.println(vacationList);

            // 오늘 날짜 String으로 미리 정의
            String today = LocalDate.now().toString();

            if (vacationList != null) {
                boolean isVacation = false;

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                for (ApprovalDto vct : vacationList) {
                    LocalDate indate = vct.getStartdate();
                    LocalDate outdate = vct.getEnddate();

                    if (indate != null && outdate != null) {
                        String startOnly = indate.toString();
                        String endOnly = outdate.toString();

                        if (today.equals(startOnly) || today.equals(endOnly) || (today.compareTo(startOnly) > 0 && today.compareTo(endOnly) < 0)) {
                            System.out.println("휴가 기간 중입니다: " + startOnly + "부터 " + endOnly + "까지");
                            model.addAttribute("indateTrue", 0);
                            model.addAttribute("outdateTrue", 0);

                            // confirmAtd가 null일 가능성 체크s
                            if (confirmAtd != null) {
                                String oldStartDay = (confirmAtd.getIndate() != null) ? sdf.format(confirmAtd.getIndate()) : null;
                                String oldEndDay = (confirmAtd.getOutdate() != null) ? sdf.format(confirmAtd.getOutdate()) : null;

                                if (oldStartDay != null && oldEndDay != null && !oldStartDay.equals(today) && !oldEndDay.equals(today)) {
                                    atds.insertAtdVct(startOnly, endOnly, 5, udto.getEmail());
                                }
                            }

                            isVacation = true;
                            break;
                        }
                    } else {
                        System.out.println("휴가 정보가 불완전합니다.");
                    }
                }

                if (!isVacation) {
                    System.out.println("휴가 기간 외입니다.");
                }
            }

            // 당일 송신 메일 확인
            int today_mail = mails.countMailToday(udto.getId());
            model.addAttribute("today_mail", today_mail);
          
            // 마이페이지 정보 조회
            InfoDto infoDto = homes.userAllInfoList(udto.getId());
            model.addAttribute("info", infoDto);

        }
        return url;
    }

    @PostMapping("/addAttendance")
    public String attendance(@RequestBody AttendanceDto atddto, HttpSession session, Model model) {
        UserDto udto = (UserDto)session.getAttribute("loginUser");
        String url = "redirect:/login";
        if (udto != null) {
            // 출근, 퇴근 기준 시간
            LocalTime cutoffLate = LocalTime.of(9, 30);   // 9:30 출근 기준
            LocalTime cutoffEarlyLeave = LocalTime.of(18, 30);   // 18:30 퇴근 기준


            if (atddto.getIndate() != null) {
                // 출근 시간 처리
                Timestamp indate = atddto.getIndate();
                LocalTime inTime = indate.toLocalDateTime().toLocalTime();

                // 지각 여부 판단
                if (inTime.isAfter(cutoffLate)) {
                    atddto.setState(1);  // 지각
                } else {
                    atddto.setState(0);  // 정시 출근
                }

                atds.insertAttendance(atddto, udto.getEmail());
            }

            if (atddto.getOutdate() != null) {
                // 퇴근 시간 처리

                int crrentstate = atds.selectState(udto.getEmail());


                Timestamp outdate = atddto.getOutdate();
                LocalTime outTime = outdate.toLocalDateTime().toLocalTime();

                // 조퇴 여부 판단
                if (outTime.isBefore(cutoffEarlyLeave)) {
                    if (crrentstate == 1) {
                        atddto.setState(3);  // 지각 + 조퇴 상태 (특별한 경우 처리)
                    } else {
                        atddto.setState(4);  // 조퇴 (지각이 아닌 경우)
                    }
                }
                atds.updateAttendance(atddto, udto.getEmail());
            }


            url = "index";
        }
        return url;
    }

}
