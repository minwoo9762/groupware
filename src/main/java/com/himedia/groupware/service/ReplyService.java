package com.himedia.groupware.service;


import com.himedia.groupware.dao.IReplyDao;
import com.himedia.groupware.dto.ReplyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {

    @Autowired
    IReplyDao rdao;

    public void insert(ReplyDto replydto) {rdao.insert(replydto);}

    public void delete(int id) {rdao.delete(id);}
}
