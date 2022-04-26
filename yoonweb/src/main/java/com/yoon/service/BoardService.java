package com.yoon.service;

import com.yoon.model.BoardVO;

import java.util.List;
import java.util.Map;

public interface BoardService {
    public List<BoardVO> boardSearch(Integer start, Integer last, String writer, String title) throws Exception;
    public void boardWrite(BoardVO boardVO) throws Exception;
    public int serchbno()throws Exception;
    public int searchcnt(String writer, String title) throws Exception;
    public List<BoardVO> selectBoard(Integer bno) throws Exception;
    public void boardRemove(Integer bno) throws  Exception;
    public void boardUpdate(String title, String content ,Integer bno) throws Exception;

}
