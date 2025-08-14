package com.himedia.groupware.dao;

import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface WorkBoardDao {

    ArrayList<WorkBoardDto> selectBoard();
}
