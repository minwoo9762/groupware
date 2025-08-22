package com.himedia.groupware.service;

import com.himedia.groupware.dao.IMailDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailService {
    @Autowired
    IMailDao mdao;
}
