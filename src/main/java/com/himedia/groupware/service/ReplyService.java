package com.himedia.groupware.service;


import com.himedia.groupware.dao.IReplyDao;
import com.himedia.groupware.dto.ReplyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {

    @Autowired
    IReplyDao rdao;

    public void insertBoard(ReplyDto replydto) {rdao.insertBoard(replydto);}
    public void insertApp(ReplyDto replydto) {rdao.insertApp(replydto);}

    public void deleteBoard(int id) {rdao.deleteBoard(id);}
    public void deleteApp(int id) {rdao.deleteApp(id);}
}
