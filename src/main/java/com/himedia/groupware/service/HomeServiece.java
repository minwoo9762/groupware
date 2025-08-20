package com.himedia.groupware.service;

import com.himedia.groupware.dao.HomeIDao;
import com.himedia.groupware.dto.VacationDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class HomeServiece {

    @Autowired
    HomeIDao hidao;


    public ArrayList<VacationDto> getVCT(int id) {
        return hidao.getVCT(id);
    }
}
