package com.himedia.groupware.dao;

import com.himedia.groupware.dto.*;
import jakarta.validation.Valid;
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




    void insertProvider(int id, String name);
    void insertPart(int id, String name);
    void insertState(int id, String name);


    void replaceProvider(int id, String name);
    void replacePart(int id, String name);
    void replaceState(int id, String name);


    void userReplaceProvider(int deleteid);void deleteProvider(int deleteid);

    void userReplaceState(Integer deleteid);void deleteState(Integer deleteid);

    void userReplacePart(Integer deleteid);void deletePart(Integer deleteid);


    NoticeDto getNoticeOne(int nseq);

    void update(@Valid NoticeDto noticedto);

    void deleteNotice(int nseq);
}
