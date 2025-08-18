package com.himedia.groupware.service;

import com.himedia.groupware.dao.AttendanceIDao;
import com.himedia.groupware.dto.AttendanceDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.AliasFor;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {

    @Autowired
    AttendanceIDao atdidao;

    public void insertAttendance(AttendanceDto atddao) {
        atdidao.insertAttendance(atddao);
    }
}
