package com.himedia.groupware.dao;

import com.himedia.groupware.dto.NoticeDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.PayDto;
import com.himedia.groupware.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface AdminIDao {

    int getAllCount(String key);
    ArrayList<UserDto> getUser(Paging paging, String key);

    void updateUser(UserDto userdto);

    ArrayList<UserDto> getNotice(Paging paging, String key);

    void selectNoticeInfo(UserDto udto);

    void insertNotice(NoticeDto noticedto);
    void updateNotice(NoticeDto noticedto);


    NoticeDto selectNoticeDetail(int nseq);

    PayDto selectPay(int id);

    UserDto findUser(int id);

    void insertPay(PayDto paydto, int id);

    void updatePay(PayDto paydto, int id);

    ArrayList<NoticeDto> currentNotice(int num);
}
