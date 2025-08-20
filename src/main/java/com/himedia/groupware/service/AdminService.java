package com.himedia.groupware.service;

import com.himedia.groupware.dao.AdminIDao;
import com.himedia.groupware.dto.NoticeDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.PayDto;
import com.himedia.groupware.dto.UserDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class AdminService {
    @Autowired
    AdminIDao adidao;

    public HashMap<String, Object> getUser(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession();


        session.removeAttribute("page");
        session.removeAttribute("key");


        int page = 1;
        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if(session.getAttribute("page") != null) {
            page = (Integer)session.getAttribute("page");
        }

        String key = "";
        if(request.getParameter("key") != null){
            key=request.getParameter("key");
            session.setAttribute("key", key);
        } else if(session.getAttribute("key") != null){
            key=(String)session.getAttribute("key");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(5);
        paging.setDisplayRow(5);

        int count = adidao.getAllCount(key);
        paging.setTotalCount(count);
        paging.calPaging();

        if( page > paging.getEndPage() ) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<UserDto> userList = adidao.getUser(paging, key);
        result.put("userList", userList);
        result.put("paging", paging);
        result.put("key", key);

        return result;

    }

    public void updateUser(UserDto userdto) {
        adidao.updateUser(userdto);
    }

    public HashMap<String, Object> getNotice(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession();


        session.removeAttribute("page");
        session.removeAttribute("key");


        int page = 1;
        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if(session.getAttribute("page") != null) {
            page = (Integer)session.getAttribute("page");
        }

        String key = "";
        if(request.getParameter("key") != null){
            key=request.getParameter("key");
            session.setAttribute("key", key);
        } else if(session.getAttribute("key") != null){
            key=(String)session.getAttribute("key");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(5);
        paging.setDisplayRow(5);

        int count = adidao.getAllCount(key);
        paging.setTotalCount(count);
        paging.calPaging();

        if( page > paging.getEndPage() ) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<UserDto> noticeList = adidao.getNotice(paging, key);
        result.put("noticeList", noticeList);
        result.put("paging", paging);
        result.put("key", key);

        return result;
    }

    public void selectNoticeInfo(UserDto udto) {
        adidao.selectNoticeInfo(udto);
    }

    public void insertNotice(NoticeDto noticedto) {
        adidao.insertNotice(noticedto);
    }

    public void updateNotice(NoticeDto noticedto) {
        adidao.updateNotice(noticedto);
    }

    public NoticeDto selectNoticeDetail(int nseq) {
        return adidao.selectNoticeDetail(nseq);
    }


    public PayDto selectPay(int id) {
            return adidao.selectPay(id);
    }

    public UserDto findUser(int id) {
        return adidao.findUser(id);
    }

    public void insertPay(PayDto paydto, int id) {
        adidao.insertPay(paydto, id);
    }

    public void updatePay(PayDto paydto, int id) {
        adidao.updatePay(paydto, id);
    }
}
