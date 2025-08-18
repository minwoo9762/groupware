package com.himedia.groupware.dao;

import com.himedia.groupware.dto.AttendanceDto;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttendanceIDao {

    void insertAttendance(AttendanceDto atddao, String email);

    void updateAttendance(AttendanceDto atddao, @NotNull @NotEmpty String email);

    AttendanceDto selectAttendance(String email);
}
