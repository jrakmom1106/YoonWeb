package com.yoon.service;


import com.yoon.mapper.BoardMapper;
import com.yoon.model.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService{

    @Autowired
    BoardMapper boardmapper;

    @Override
    public List<BoardVO> boardSearch() throws Exception {
        return boardmapper.boardSearch();
    }

    @Override
    public void boardWrite(BoardVO boardVO) throws Exception {
        boardmapper.boardWrite(boardVO);
    }

    @Override
    public int serchbno() throws Exception {
        return boardmapper.searchbno();
    }
}
