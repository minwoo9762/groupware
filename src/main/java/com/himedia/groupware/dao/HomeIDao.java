package com.himedia.groupware.dao;

import com.himedia.groupware.dto.InfoDto;
import com.himedia.groupware.dto.VacationDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface HomeIDao {

    ArrayList<VacationDto> getVCT(int id);

    InfoDto userAllInfoList(int id);
}
