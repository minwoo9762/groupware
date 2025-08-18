package com.himedia.groupware.dto;

import lombok.Data;

@Data
public class Paging {
    private int page;
    private int totalCount;
    private int displayRow=3;
    private int displayPage=5;
    private int beginPage;
    private int endPage;
    private boolean prev;
    private boolean next;
    private int startNum;
    private int endNum;

    public void calPaging() {
        if(page < 1) page = 1;
        endPage = ((int) (Math.ceil(page / (double) displayPage))) * displayPage;
        beginPage = endPage - (displayPage - 1);
        int totalPage = (int) Math.ceil(totalCount / (double) displayRow);
        if (totalPage < endPage) {
            endPage = totalPage;    next = false;
        } else {
            next = true;
        }
        prev = (beginPage == 1) ? false : true;
        startNum = (page - 1) * displayRow;
        endNum = page * displayRow;
        System.out.println(beginPage + " " + endPage + " " + startNum + " " + endNum);
    }

}
