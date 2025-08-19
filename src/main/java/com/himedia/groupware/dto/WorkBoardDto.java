package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class WorkBoardDto {
    private int id;
    private int userid;
    private int part;
    private String content;
    private String name;
    private String title;
    private Timestamp indate;
    private int replycnt;
    private String image;
    private String savefilename;

}
