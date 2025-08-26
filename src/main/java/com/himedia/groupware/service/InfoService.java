package com.himedia.groupware.service;

import com.himedia.groupware.dao.IInfoDao;
import com.himedia.groupware.dto.InfoDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InfoService {
    @Autowired
    IInfoDao idao;

    public InfoDto getInfo(int id) {
        return idao.getInfo(id);
    }
}
