package com.yoon.mapper;

import com.yoon.model.BoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    List<BoardVO> boardSearch(Integer start, Integer last, String writer,String title);
    void boardWrite(BoardVO boardVO);
    int searchbno();
    int searchcnt(String writer, String title);
    List<BoardVO> selectBoard(Integer bno);
    void boardRemove(Integer bno);
    void boardUpdate(String title, String content,Integer bno);
}
