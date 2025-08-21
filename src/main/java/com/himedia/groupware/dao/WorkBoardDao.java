package com.himedia.groupware.dao;

import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.validation.Valid;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface WorkBoardDao {


    int getAllCount();

    ArrayList<WorkBoardDto> selectBoard(Paging paging, String key, String part);

    void addReadCount(int id);

    WorkBoardDto getBoard(int id);

    void insert(@Valid WorkBoardDto boarddto);

    void update(@Valid WorkBoardDto boarddto);

    void delete(int id);

    int getAllCountForBoard(String key, String part);

}
