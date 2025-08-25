package com.himedia.groupware.service;

import com.himedia.groupware.dao.IUserDao;
import com.himedia.groupware.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyPageService {
    @Autowired
    IUserDao udao;

    public void updateUser(UserDto userdto) {
        udao.updateUser(userdto);
    }
}
