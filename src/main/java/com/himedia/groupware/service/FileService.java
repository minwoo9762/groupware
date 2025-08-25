package com.himedia.groupware.service;

import com.himedia.groupware.dao.FileDao;
import com.himedia.groupware.dto.FileDto;
import com.himedia.groupware.dto.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

;import java.util.ArrayList;
import java.util.HashMap;

@Service
public class FileService {

    @Autowired
    FileDao fdao;


    public HashMap<String, Object> selectFile(HttpServletRequest request) {
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
        int count = fdao.getAllCountForFile(key,  part);
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        ArrayList<FileDto> list = fdao.selectFile(paging, key, part);
        result.put("fileList", list);
        result.put("paging", paging);
        result.put("key", key);
        result.put("part", part);
        return result;
    }

    public void insert(@Valid FileDto filedto) {fdao.insert(filedto);}

    public void delete(int id) {fdao.delete(id);}
}
