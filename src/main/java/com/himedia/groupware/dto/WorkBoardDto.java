package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class WorkBoardDto {
    private int id;
    private String pass;
    private String userid;
    private String content;
    private String name;
    private String title;
    private Timestamp indate;

}
