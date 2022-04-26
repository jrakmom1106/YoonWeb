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
    public List<BoardVO> boardSearch(Integer start, Integer last, String writer, String title) throws Exception {
        return boardmapper.boardSearch(start,last,writer,title);
    }

    @Override
    public void boardWrite(BoardVO boardVO) throws Exception {
        boardmapper.boardWrite(boardVO);
    }

    @Override
    public int serchbno() throws Exception {
        return boardmapper.searchbno();
    }
    @Override
    public int searchcnt(String writer , String title) throws Exception{
        return boardmapper.searchcnt(writer,title);
    }

    @Override
    public List<BoardVO> selectBoard(Integer bno){
        return boardmapper.selectBoard(bno);
    }

    @Override
    public void boardRemove(Integer bno){ boardmapper.boardRemove(bno);}

    @Override
    public void boardUpdate(String title, String content, Integer bno){ boardmapper.boardUpdate(title,content,bno);}
}
