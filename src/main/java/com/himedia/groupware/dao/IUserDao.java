package com.himedia.groupware.dao;

import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.UserDto;
import jakarta.validation.Valid;
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
    int getAllCountForAddress(String key);
    ArrayList<UserDto> selectAddress(Paging paging, String key);
    void insert(@Valid UserDto userdto);
}
