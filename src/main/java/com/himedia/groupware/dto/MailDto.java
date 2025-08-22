package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MailDto {
    private int id;
    private int sender;
    private int receiver;
    private String subject;
    private String content;
    private Timestamp indate;
    private boolean read;
    private boolean reply;
}
