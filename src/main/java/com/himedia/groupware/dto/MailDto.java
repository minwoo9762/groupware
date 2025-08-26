package com.himedia.groupware.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class MailDto {
    private int id;
    private int senderId;
    private String senderName;
    private int receiverId;
    @NotNull @NotEmpty
    private String receiverName;
    @NotNull @NotEmpty
    private String subject;
    @NotNull @NotEmpty
    private String content;
    private Timestamp indate;
    private boolean read;
    private int reply;
    private int replyCount;
}
