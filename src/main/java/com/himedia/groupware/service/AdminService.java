package com.himedia.groupware.service;

import com.himedia.groupware.dao.AdminIDao;
import com.himedia.groupware.dto.*;
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
        paging.setDisplayPage(5);
        paging.setDisplayRow(5);

        int count = adidao.getAllCount(key);
        if(count == 0) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
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
        paging.setDisplayPage(5);
        paging.setDisplayRow(5);

        int count = adidao.getAllCountNotice(key);
        if(count == 0) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
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

    public ArrayList<NoticeDto> currentNotice(int num) {
        return adidao.currentNotice(num);
    }

    
    /* 어드민 직책, 부서, 상태*/
    public ArrayList<AsInfoDto> getProvider() {
        return adidao.getProvider();
    }

    public ArrayList<AsInfoDto> getPart() {
        return adidao.getPart();
    }

    public ArrayList<AsInfoDto> getState() {
        return adidao.getState();
    }







    /*추가(인설트)*/
    public void insertProvider(int id, String name) {
        adidao.insertProvider(id, name);
    }
    public void insertPart(int id, String name) {
        adidao.insertPart(id, name);
    }
    public void insertState(int id, String name) {
        adidao.insertState(id, name);
    }

    /*업데이트*/
    public void replaceProvider(int id, String name) {
        adidao.replaceProvider(id, name);
    }
    public void replacePart(int id, String name) {
        adidao.replacePart(id, name);
    }
    public void replaceState(int id, String name) {
        adidao.replaceState(id, name);
    }

    /*프로바이더 삭제*/
    public void userReplaceProvider(int deleteid) {
        adidao.userReplaceProvider(deleteid);
    }
    public void deleteProvider(int deleteid) {
        adidao.deleteProvider(deleteid);
    }

    /* 파트 삭제*/
    public void userReplacePart(Integer deleteid) {
        adidao.userReplacePart(deleteid);
    }
    public void deletePart(Integer deleteid) {
        adidao.deletePart(deleteid);
    }


    /*스테이트 삭제*/
    public void userReplaceState(Integer deleteid) {
        adidao.userReplaceState(deleteid);
    }
    public void deleteState(Integer deleteid) {
        adidao.deleteState(deleteid);
    }

}
