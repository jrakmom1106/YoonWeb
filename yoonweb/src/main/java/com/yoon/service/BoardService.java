package com.yoon.service;

import com.yoon.model.BoardVO;

import java.util.List;
import java.util.Map;

public interface BoardService {
    public List<BoardVO> boardSearch() throws Exception;
    public void boardWrite(BoardVO boardVO) throws Exception;
    public int serchbno()throws Exception;
}
