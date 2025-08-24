package com.himedia.groupware.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
public class FileDto {
    private int id;
    private String originalname;
    private String savedname;
    private Timestamp uploadtime;
    private int userid;
    private String title;
    private String part;
    private String name;

}

