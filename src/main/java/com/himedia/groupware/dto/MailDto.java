package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MailDto {
    private int id;
    private int senderId;
    private String senderName;
    private int receiverId;
    private String receiverName;
    private String subject;
    private String content;
    private Timestamp indate;
    private boolean read;
    private int reply;
}
