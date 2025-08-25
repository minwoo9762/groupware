package com.himedia.groupware.dao;

import com.himedia.groupware.dto.InfoDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IInfoDao {
    InfoDto getInfo(String name);
}
