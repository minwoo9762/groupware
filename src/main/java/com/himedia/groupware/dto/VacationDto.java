package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class VacationDto {
    private int pseq;  // 수정
    private String userid;
    private String title;
    private String content;
    private Timestamp indate;
    private Timestamp outdate; // 추가
    private String checkyn; // 추가
}
