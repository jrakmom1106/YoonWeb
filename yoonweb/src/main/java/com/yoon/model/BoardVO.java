package com.yoon.model;

import java.util.Date;

public class BoardVO {
    //Field
    private int bno;        //게시물번호
    private String title;    //게시물제목
    private String content;    //게시물내용
    private String writer;    //게시물작성자
    private String regdate;    //게시물작성일자
    private int viewcnt;    //게시물조회수


    public int getBno() {
        return bno;
    }

    public void setBno(int bno) {
        this.bno = bno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public int getViewcnt() {
        return viewcnt;
    }

    public void setViewcnt(int viewcnt) {
        this.viewcnt = viewcnt;
    }

    @Override
    public String toString() {
        return "BoardVO{" +
                "bno=" + bno +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", writer='" + writer + '\'' +
                ", regdate='" + regdate + '\'' +
                ", viewcnt=" + viewcnt +
                '}';
    }
}
