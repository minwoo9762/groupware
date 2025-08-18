package com.himedia.groupware.dto;

import lombok.Data;

import java.sql.Timestamp;


@Data
public class WorkUserDto {
    private int id;
    private String email;
    private String pwd;
    private String name;
    private String phone;
    private int part;
    private String address1;
    private String address2;
    private Timestamp indate;
    private String profileimg;
}
