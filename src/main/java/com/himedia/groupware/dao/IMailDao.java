package com.himedia.groupware.dao;

import com.himedia.groupware.dto.MailDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IMailDao {
    ArrayList<MailDto> getRecentSendMail(int id);
    ArrayList<MailDto> getRecentReceiveMail(int id);
    int getAllCountForMail(String key);
    ArrayList<MailDto> getSendMail(int id);
    ArrayList<MailDto> getReceiveMail(int id);

}
