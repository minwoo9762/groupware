package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ReplyDto {
    private int id;
    private int userid;
    private int boardid;
    private int appid;
    private int provider;
    private String name;
    private String reply;
    private Timestamp writedate;


}
