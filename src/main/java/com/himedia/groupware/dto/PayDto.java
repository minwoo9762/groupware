package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class PayDto {
    private int pseq;
    private String title;
    private String content;
    private Timestamp indate;
}
