package com.himedia.groupware.service;

import com.himedia.groupware.dao.HrDao;
import com.himedia.groupware.dto.AttendanceDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HrService {

    @Autowired
    HrDao hdao;

    public List<AttendanceDto> getAttendanceListByUserId(int id) {
        return hdao.selectAttendanceByUserId(id);
    }
}
