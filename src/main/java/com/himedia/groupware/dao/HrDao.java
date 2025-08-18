package com.himedia.groupware.dao;

import com.himedia.groupware.dto.AttendanceDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HrDao {
    List<AttendanceDto> selectAttendanceByUserId(int id);
}
