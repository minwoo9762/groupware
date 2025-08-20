package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class PayDto {
    private int pseq;
    private int id;
    private int pay;
    private String title;
    private String content;
    private Timestamp indate;
}
