package com.yoon.mapper;

import com.yoon.model.BoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    List<BoardVO> boardSearch();
    void boardWrite(BoardVO boardVO);
    int searchbno();
}
