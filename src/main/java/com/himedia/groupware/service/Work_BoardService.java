package com.himedia.groupware.service;

import com.himedia.groupware.dao.WorkBoardDao;
import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class Work_BoardService {

    @Autowired
    WorkBoardDao bdao;

    public HashMap<String, Object> selectBoard(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();
        ArrayList<WorkBoardDto> list = bdao.selectBoard();
        result.put("BoardList", list);
        System.out.println((list));
        return result;
    }
}
