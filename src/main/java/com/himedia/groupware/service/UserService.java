package com.himedia.groupware.service;

import com.himedia.groupware.dao.IUserDao;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.UserDto;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
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

    public boolean isValidName(String name) {
        return udao.isValidName(name);
    }

    public int getUseridByName(String name) {
        return udao.getUseridByName(name);
    }

    public HashMap<String, Object> selectAddress(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
        }

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if (session.getAttribute("page") != null) {
            page = (Integer) session.getAttribute("page");
        }
        String key = "";
        if (request.getParameter("key") != null) {
            key = request.getParameter("key");
            session.setAttribute("key", key);
        } else if (session.getAttribute("key") != null) {
            key = (String) session.getAttribute("key");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = udao.getAllCountForAddress(key);
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<UserDto> list = udao.selectAddress(paging, key);
        result.put("userList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public void insert(@Valid UserDto userdto) {udao.insert(userdto);}

}
