package com.himedia.groupware.dao;

import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.Paging;
import jakarta.validation.Valid;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

@Mapper
public interface ApprovalDao {
    int getAllCountForApp(String key, String part);


    ApprovalDto getApp(int id);

    ArrayList<ApprovalDto> selectApp(Paging paging, String key, String part);

    ApprovalDto getAppList();

    void delete(int id);

    void insert(@Valid ApprovalDto approvaldto);

    void updateStatus(@Param("id") int id, @Param("status") int status);


}
