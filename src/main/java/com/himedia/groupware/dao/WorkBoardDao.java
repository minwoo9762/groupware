package com.himedia.groupware.dao;

import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface WorkBoardDao {


    int getAllCount();

    ArrayList<WorkBoardDto> selectBoard(Paging paging);

    void addReadCount(int id);

    Object getBoard(int id);

    void insert(@Valid WorkBoardDto boarddto);
}
