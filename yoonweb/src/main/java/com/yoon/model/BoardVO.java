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

    //게시물 인덱스
    private int NUM;

    //게시물 파일
    private String filename;
    private String filerealname;

    public String getFilerealname() {
        return filerealname;
    }

    public void setFilerealname(String filerealname) {
        this.filerealname = filerealname;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public int getNUM() {
        return NUM;
    }

    public void setNUM(int NUM) {
        this.NUM = NUM;
    }



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
                ", NUM=" + NUM +
                ", filename='" + filename + '\'' +
                ", filerealname='" + filerealname + '\'' +
                '}';
    }
}
