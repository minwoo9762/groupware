package com.himedia.groupware.service;

import com.himedia.groupware.dao.AttendanceIDao;
import com.himedia.groupware.dto.AttendanceDto;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Service
public class AttendanceService {

    @Autowired
    AttendanceIDao atdidao;

    public void insertAttendance(AttendanceDto atddto, String email) {
        atdidao.insertAttendance(atddto, email);
    }

    public void updateAttendance(AttendanceDto atddto, String email) {
        atdidao.updateAttendance(atddto, email);
    }

    public AttendanceDto selectAttendance(String email) {
        return atdidao.selectAttendance(email);

    }

    public int selectState( String email) {
        return atdidao.selectState(email);
    }

    public void insertAtdVct(String startOnly, String endOnly, int i, String email) {
         atdidao.insertAtdVct(startOnly, endOnly, i, email);

    }
}
