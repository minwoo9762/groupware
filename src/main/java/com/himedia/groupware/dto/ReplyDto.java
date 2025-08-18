package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ReplyDto {
    private int id;
    private int userId;
    private int boardId;
    private String reply;
    private Timestamp writedate;
}
