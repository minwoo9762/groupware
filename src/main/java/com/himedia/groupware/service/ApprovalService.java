package com.himedia.groupware.service;

import com.himedia.groupware.dao.ApprovalDao;
import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.WorkBoardDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class ApprovalService {

    @Autowired
    ApprovalDao adao;

    public HashMap<String, Object> selectApp(HttpServletRequest request) {
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
        int count = adao.getAllCountForApp(key);
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<ApprovalDto> list = adao.selectApp(paging, key);
        result.put("appList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public HashMap<String, Object> getApp(int id) {
        HashMap<String, Object> result = new HashMap<>();

        result.put("app",adao.getApp(id));

        return result;
    }

    public ApprovalDto getAppList() {
        return adao.getAppList();
    }
}
