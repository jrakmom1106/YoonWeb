package com.yoon.service;

import com.yoon.model.BoardVO;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface BoardService {
    public List<BoardVO> boardSearch(Integer start, Integer last, String writer, String title) throws Exception;
    void boardWrite(Map<String, Object> param) throws Exception;
    public int serchbno()throws Exception;
    public int searchcnt(String writer, String title) throws Exception;
    public List<BoardVO> selectBoard(Integer bno) throws Exception;
    public void boardRemove(Integer bno) throws  Exception;
    public void boardUpdate(String title, String content ,Integer bno) throws Exception;
    public Map<String,String> createfileList(MultipartHttpServletRequest req) throws IOException;
    public Map<String, Object> boardDetail(Map<String, Object>param);

}
