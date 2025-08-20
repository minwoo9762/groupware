package com.himedia.groupware.service;

import com.himedia.groupware.dao.HrDao;
import com.himedia.groupware.dto.AttendanceDto;
import com.himedia.groupware.dto.Paging;
import com.himedia.groupware.dto.PayDto;
import com.himedia.groupware.dto.VacationDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HrService {

    @Autowired
    HrDao hdao;

    public List<AttendanceDto> selectAttendanceByUserId(int aseq) {
        return hdao.selectAttendanceByUserId(aseq);
    }

    public HashMap<String, Object> selectPay(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession();

        if( request.getParameter("first") != null ) {
            session.removeAttribute("page");
            session.removeAttribute("key");
        }

        int page=1;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        }else if( session.getAttribute("page") != null){
            page = (Integer) session.getAttribute("page");
        }

        String key="";
        if( request.getParameter("key") != null){
            key=request.getParameter("key");
            session.setAttribute("key", key);
        }else if( session.getAttribute("key") != null){
            key = (String)session.getAttribute("key");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(5);
        paging.setDisplayRow(5);
        int count = hdao.getAllCountForPay( key );
        paging.setTotalCount(count);
        paging.calPaging();

        if( page > paging.getEndPage() ) {
            paging.setPage( paging.getEndPage() );
            paging.calPaging();
        }

        ArrayList<PayDto> list = hdao.selectPay(paging, key);
        result.put("payList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }


    public PayDto getPay(int pseq) {
        return hdao.getPay(pseq);
    }

    public HashMap<String, Object> selectVacation(HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession();

        if( request.getParameter("first") != null ) {
            session.removeAttribute("page");
            session.removeAttribute("key");
        }

        int page=1;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        }else if( session.getAttribute("page") != null){
            page = (Integer) session.getAttribute("page");
        }

        String key="";
        if( request.getParameter("key") != null){
            key=request.getParameter("key");
            session.setAttribute("key", key);
        }else if( session.getAttribute("key") != null){
            key = (String)session.getAttribute("key");
        }

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(5);
        paging.setDisplayRow(5);
        int count = hdao.getAllCountForVacation( key );
        paging.setTotalCount(count);
        paging.calPaging();

        if( page > paging.getEndPage() ) {
            paging.setPage( paging.getEndPage() );
            paging.calPaging();
        }

        ArrayList<PayDto> list = hdao.selectVacation(paging, key);
        result.put("vacationList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public VacationDto getVacation(int pseq) {
        return hdao.getVacation(pseq);
    }
}
