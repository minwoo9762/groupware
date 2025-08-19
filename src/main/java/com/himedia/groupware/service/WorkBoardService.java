package com.himedia.groupware.service;

import com.himedia.groupware.dao.IReplyDao;
import com.himedia.groupware.dao.WorkBoardDao;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
        }

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if (session.getAttribute("page") != null) {
            page = (Integer) session.getAttribute("page");
        }
        String key = "";
        if (request.getParameter("key") != null) {
            key = request.getParameter("key");
            session.setAttribute("key", key);
        } else if (session.getAttribute("key") != null) {
            key = (String) session.getAttribute("key");
        }
        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = bdao.getAllCountForBoard(key);
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<WorkBoardDto> list = bdao.selectBoard(paging, key);
        result.put("boardList", list);
        result.put("paging", paging);
        result.put("key", key);
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

    public HashMap<String, Object> getBoardWithoutCnt(int id) {
        HashMap<String, Object> result = new HashMap<>();

        result.put("board",bdao.getBoard(id));
        System.out.println(bdao.getBoard(id));

        result.put("replyList", rdao.selectReply(id));

        return result;
    }


    public WorkBoardDto getBoardOne(int id) {
        return bdao.getBoard(id);
    }

    public void update(WorkBoardDto boarddto) {
        bdao.update(boarddto);
    }

    public void delete(int id) {bdao.delete(id);}



}
