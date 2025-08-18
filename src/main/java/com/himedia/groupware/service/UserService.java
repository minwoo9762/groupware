package com.himedia.groupware.service;

import com.himedia.groupware.dao.IUserDao;
import com.himedia.groupware.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    IUserDao udao;

    public UserDto getUser(String email) {
        return udao.getUser(email);
    }

    public void insertUser(UserDto userdto) {
        udao.insertUser(userdto);
    }

    public void updatePwd(String email, String pwd) {
        udao.updatePwd(email, pwd);
    }
}
