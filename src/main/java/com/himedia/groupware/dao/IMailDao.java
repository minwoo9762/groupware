package com.himedia.groupware.dao;

import com.himedia.groupware.dto.MailDto;
import com.himedia.groupware.dto.Paging;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IMailDao {
    ArrayList<MailDto> getRecentSendMail(int id);
    ArrayList<MailDto> getRecentReceiveMail(int id);
    int getAllCountForReceiveMail(String key);
    ArrayList<MailDto> getReceiveMail(int id, Paging paging, String key);
    int getAllCountForSendMail(String key);
    ArrayList<MailDto> getSendMail(int id, Paging paging, String key);
    MailDto getMail(int id);
    void setRead(int id);
    ArrayList<MailDto> getRepliedList(int id);
    void insertMail(MailDto maildto);
    void deleteReply(int id);
    void deleteMail(int id);
    int countMailToday(int id);
}
