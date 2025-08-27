package com.himedia.groupware.service;

import com.himedia.groupware.dao.HomeIDao;
import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.InfoDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class HomeServiece {

    @Autowired
    HomeIDao hidao;


    public ArrayList<ApprovalDto> getVCT(int id) {
        return hidao.getVCT(id);
    }

    public InfoDto userAllInfoList(int id) {
        return hidao.userAllInfoList(id);
    }
}
