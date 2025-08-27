package com.himedia.groupware.service;

import com.himedia.groupware.dao.ApprovalDao;
import com.himedia.groupware.dao.IReplyDao;
import com.himedia.groupware.dto.ApprovalDto;
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
public class ApprovalService {

    @Autowired
    ApprovalDao adao;

    @Autowired
    IReplyDao rdao;

    public HashMap<String, Object> selectApp(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
            session.removeAttribute("part");
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

        String part = "";
        if (request.getParameter("part") != null) {
            part = request.getParameter("part");
            session.setAttribute("part", part);
        } else if (session.getAttribute("part") != null) {
            part = (String) session.getAttribute("part");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = adao.getAllCountForApp(key, part);
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();


        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<ApprovalDto> list = adao.selectApp(paging, key, part);
        result.put("appList", list);
        result.put("paging", paging);
        result.put("key", key);
        result.put("part", part);
        return result;
    }

    public HashMap<String, Object> getApp(int id) {
        HashMap<String, Object> result = new HashMap<>();

        result.put("app", adao.getApp(id));
        result.put("replyList", rdao.selectAppReply(id));
        System.out.println(id);

        return result;
    }

    public void delete(int id) {adao.delete(id);}

    public void insert(@Valid ApprovalDto approvaldto) {adao.insert(approvaldto);}

    public void updateStatus(int id, int status) {
        adao.updateStatus(id, status);
    }






    public void ajaxViewDate(ApprovalDto approvaldto) {
        adao.ajaxViewDate(approvaldto);
    }
}
