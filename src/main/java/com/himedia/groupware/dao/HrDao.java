package com.himedia.groupware.dao;

import com.himedia.groupware.dto.AttendanceDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.PayDto;
import com.himedia.groupware.dto.VacationDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface HrDao {
    List<AttendanceDto> selectAttendanceByUserId(int aseq);

    int getAllCountForPay(String key);

    ArrayList<PayDto> selectPay(Paging paging, String key);

    PayDto getPay(int pseq);

    int getAllCountForVacation(String key);

    ArrayList<PayDto> selectVacation(Paging paging, String key);

    VacationDto getVacation(int pseq);
}
