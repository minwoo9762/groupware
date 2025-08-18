package com.himedia.groupware.service;

import com.himedia.groupware.dao.IReplyDao;
import com.himedia.groupware.dao.WorkBoardDao;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class WorkBoardService {

    @Autowired
    WorkBoardDao bdao;

    @Autowired
    IReplyDao rdao;

    public HashMap<String, Object> selectBoard(HttpServletRequest request) {

        HashMap<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession();
        int page = 1;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        }else if(session.getAttribute("page") != null){
            page = (Integer)session.getAttribute("page");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        int count = bdao.getAllCount();
        paging.setTotalCount(count);
        paging.calPaging();

        ArrayList<WorkBoardDto> list = bdao.selectBoard(paging);

        for(WorkBoardDto bdto : list){
            int cnt = rdao.getReplyCount(bdto.getId());
            bdto.setReplycnt(cnt);
        }
        result.put("BoardList", list);
        result.put("paging", paging);
        return result;
    }


    public HashMap<String, Object> getBoard(int id) {
        HashMap<String, Object> result = new HashMap<>();

        bdao.addReadCount(id);
        result.put("board",bdao.getBoard(id));
        result.put("replyList", rdao.selectReply(id));



        return result;
    }

    public void insert(@Valid WorkBoardDto boarddto) {
        bdao.insert(boarddto);
    }
}
