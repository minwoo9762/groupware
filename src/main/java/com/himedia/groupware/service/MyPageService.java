package com.himedia.groupware.service;

import com.himedia.groupware.dao.IUserDao;
import com.himedia.groupware.dto.UserDto;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyPageService {
    @Autowired
    IUserDao udao;

    public void updatePwd(String pwd, String email) {
        udao.updatePwd(pwd, email);
    }

    public void updateUser(UserDto userdto) {
        udao.updateUser(userdto);
    }
}
