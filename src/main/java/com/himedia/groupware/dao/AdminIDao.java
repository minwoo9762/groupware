package com.himedia.groupware.dao;

import com.himedia.groupware.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface AdminIDao {

    int getAllCount(String key);
    ArrayList<UserDto> getUser(Paging paging, String key);

    void updateUser(UserDto userdto);

    int getAllCountNotice(String key);
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

    ArrayList<AsInfoDto> getProvider();

    ArrayList<AsInfoDto> getPart();

    ArrayList<AsInfoDto> getState();
}
