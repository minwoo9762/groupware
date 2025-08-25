package com.himedia.groupware.dao;

import com.himedia.groupware.dto.FileDto;
import com.himedia.groupware.dto.Paging;
import jakarta.validation.Valid;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Mapper
public interface FileDao {

    int getAllCountForFile(String key, String part);

    ArrayList<FileDto> selectFile(Paging paging, String key, String part);

    void insert(@Valid FileDto filedto);

    void delete(int id);
}
