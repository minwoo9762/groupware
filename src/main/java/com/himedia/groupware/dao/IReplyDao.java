package com.himedia.groupware.dao;

import com.himedia.groupware.dto.ReplyDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IReplyDao {
    ArrayList<ReplyDto> selectReply(int id);

    void insert(ReplyDto replydto);

    void delete(int replydto);

    int getReplyCount(int id);
}
