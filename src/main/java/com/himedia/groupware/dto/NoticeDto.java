package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class NoticeDto {
    private int nseq;
    private int id;
    private String userid;
    private Timestamp indate;
    private String title;
    private String content;
    private String image;
    private String savefilename;
}
