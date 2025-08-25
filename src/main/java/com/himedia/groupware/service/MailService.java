package com.himedia.groupware.service;

import com.himedia.groupware.dao.IMailDao;
import com.himedia.groupware.dto.ApprovalDto;
import com.himedia.groupware.dto.MailDto;
import com.himedia.groupware.dto.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class MailService {
    @Autowired
    IMailDao mdao;

    public HashMap<String, Object> getRecentMail(int id) {
        HashMap<String, Object> result = new HashMap<>();
        result.put("sendList",  mdao.getRecentSendMail(id));
        result.put("receiveList", mdao.getRecentReceiveMail(id));
        return result;
    }

    public HashMap<String, Object> selectMail(HttpServletRequest request) {
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
        int count = mdao.getAllCountForMail(key);
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();


        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }
        int id = Integer.parseInt((String) session.getAttribute("id"));
        ArrayList<MailDto> sendList = mdao.getSendMail(id);
        ArrayList<MailDto> receiveList = mdao.getReceiveMail(id);

        result.put("sendList", sendList);
        result.put("receiveList", receiveList);
        result.put("paging", paging);
        result.put("key", key);
        result.put("part", part);
        return result;
    }

}
