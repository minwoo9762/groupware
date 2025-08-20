package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ApprovalDto {
    private int id;
    private String username;
    private int provider;
    private String title;
    private String content;
    private Timestamp indate;
    private int category;
    private int status;

}
