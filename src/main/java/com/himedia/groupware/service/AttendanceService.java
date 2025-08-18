package com.himedia.groupware.service;

import com.himedia.groupware.dao.AttendanceIDao;
import com.himedia.groupware.dto.AttendanceDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {

    @Autowired
    AttendanceIDao atdidao;

    public void insertAttendance(AttendanceDto atddao, String email) {
        atdidao.insertAttendance(atddao, email);
    }

    public void updateAttendance(AttendanceDto atddao, String email) {
        atdidao.updateAttendance(atddao, email);
    }

    public AttendanceDto selectAttendance(String email) {
        return atdidao.selectAttendance(email);

    }
}
