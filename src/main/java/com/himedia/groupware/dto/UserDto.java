package com.himedia.groupware.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class UserDto {
    private int id;
    @NotNull @NotEmpty
    private String email;
    @NotNull @NotEmpty
    private String pwd;
    @NotNull @NotEmpty
    private String name;
    @NotNull @NotEmpty
    private String phone;
    private int part;
    private int zipNum;
    @NotNull @NotEmpty
    private String address1;
    @NotNull @NotEmpty
    private String address2;
    private String address3;
    private Timestamp indate;
    private int provider;
    private int state;
    private String profileimg;
}
