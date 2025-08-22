package com.himedia.groupware.service;

import com.himedia.groupware.dao.IUserDao;
import com.himedia.groupware.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.regex.Pattern;

@Service
public class UserService {
    @Autowired
    IUserDao udao;
    private static final String PWD_REGEX =
            "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()-+=]).{8,20}$";
    private static final Pattern pattern = Pattern.compile(PWD_REGEX);

    public UserDto getUser(String email) {
        return udao.getUser(email);
    }

    public void insertUser(UserDto userdto) {
        udao.insertUser(userdto);
    }

    public void updatePwd(String email, String pwd) {
        udao.updatePwd(email, pwd);
    }

    public boolean isValidPwd(String pwd) {
        if(pwd == null)
            return false;
        return pattern.matcher(pwd).matches();
    }

    public ArrayList<UserDto> getAllUser() {
        return udao.getAllUser();
    }
}
