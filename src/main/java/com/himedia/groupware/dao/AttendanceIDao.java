package com.himedia.groupware.dao;

import com.himedia.groupware.dto.AttendanceDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttendanceIDao {

    void insertAttendance(AttendanceDto atddao);
}
