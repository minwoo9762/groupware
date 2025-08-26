package com.himedia.groupware.dao;

import com.himedia.groupware.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IUserDao {
    UserDto getUser(String email);
    void insertUser(UserDto userdto);
    void updatePwd(String email, String pwd);
    void updateUser(UserDto userdto);
    ArrayList<UserDto> getAllUser();
    boolean isValidName(String name);
    int getUseridByName(String name);
}
