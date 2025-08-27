package com.himedia.groupware.service;

import com.himedia.groupware.dao.IMailDao;
import com.himedia.groupware.dto.MailDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.UserDto;
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
        ArrayList<MailDto> test = mdao.getRecentSendMail(id);
        return result;
    }

    public HashMap<String, Object> getMailList(HttpServletRequest request, String opt) {
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
        int count = 0;
        if(opt.equals("r"))
            count = mdao.getAllCountForReceiveMail(key);
        else if(opt.equals("s"))
            count = mdao.getAllCountForSendMail(key);
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }
        int id = ((UserDto) session.getAttribute("loginUser")).getId();
        if(opt.equals("r")) {
            ArrayList<MailDto> receiveList = mdao.getReceiveMail(id, paging, key);
            result.put("receiveList", receiveList);
        }
        else if(opt.equals("s")) {
            ArrayList<MailDto> sendList = mdao.getSendMail(id, paging, key);
            result.put("sendList", sendList);
        }
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public MailDto getMail(int id) {
        return mdao.getMail(id);
    }

    public void setRead(int id) {
        mdao.setRead(id);
    }

    public ArrayList<MailDto> getRepliedList(int id) {
        return mdao.getRepliedList(id);
    }

    public void insertMail(MailDto maildto) {
        mdao.insertMail(maildto);
    }

    public void deleteMail(int id) {
        mdao.deleteReply(id);
        mdao.deleteMail(id);
    }

    public int countMailToday(int id) {
        return mdao.countMailToday(id);
    }

    public MailDto getLatestMail(int senderid) {
        return mdao.getLatestMail(senderid);
    }
}
