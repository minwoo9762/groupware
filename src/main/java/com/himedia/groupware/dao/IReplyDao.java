package com.himedia.groupware.dao;

import com.himedia.groupware.dto.ReplyDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IReplyDao {
    ArrayList<ReplyDto> selectBoardReply(int id);
    ArrayList<ReplyDto> selectAppReply(int id);

    void insertBoard(ReplyDto replydto);
    void insertApp(ReplyDto replydto);

    void deleteBoard(int replydto);
    void deleteApp(int replydto);

    int getReplyCount(int id);


}
