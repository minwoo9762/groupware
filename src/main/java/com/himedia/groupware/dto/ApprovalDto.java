package com.himedia.groupware.dto;

import lombok.Data;

@Data
public class ApprovalDto {
    private int id;
    private String name;
    private int provider;
    private String title;
    private String content;

}
