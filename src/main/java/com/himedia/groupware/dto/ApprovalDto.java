package com.himedia.groupware.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ApprovalDto {
    private int id;
    private String username;
    private int provider;
    private String title;
    private String content;
    private Timestamp indate;
    private int category;
    private int status;
    private String part;

    
    
    /*정진추가*/
    private int userid;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startdate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate enddate;

}
