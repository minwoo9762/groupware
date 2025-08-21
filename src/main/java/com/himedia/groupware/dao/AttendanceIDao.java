package com.himedia.groupware.dao;

import com.himedia.groupware.dto.AttendanceDto;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import org.apache.ibatis.annotations.Mapper;

import java.sql.Timestamp;

@Mapper
public interface AttendanceIDao {

    void insertAttendance(AttendanceDto atddto, String email);

    void updateAttendance(AttendanceDto atddto,  String email);

    AttendanceDto selectAttendance(String email);

    int selectState(String email);

    void insertAtdVct(String startOnly, String endOnly, int i, String email);
}
