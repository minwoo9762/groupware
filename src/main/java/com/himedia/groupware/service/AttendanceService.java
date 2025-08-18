package com.himedia.groupware.service;

import com.himedia.groupware.dao.AttendanceIDao;
import com.himedia.groupware.dto.AttendanceDto;
import org.springframework.core.annotation.AliasFor;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {

    @AliasFor
    AttendanceIDao atdidao;

    public void insertAttendance(AttendanceDto atddao) {
        atdidao.insertAttendance(atddao);
    }
}
