package com.himedia.groupware.dao;

import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.WorkBoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface ApprovalDao {
    int getAllCountForApp(String key);
    

    ApprovalDto getApp(int id);


    ArrayList<ApprovalDto> selectApp(Paging paging, String key);

    ApprovalDto getAppList();
}
