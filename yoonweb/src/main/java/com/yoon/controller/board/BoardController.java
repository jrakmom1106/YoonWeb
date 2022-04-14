package com.yoon.controller.board;

import com.google.gson.Gson;
import com.yoon.model.BoardVO;
import com.yoon.service.BoardService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping(value = "/board/search.do")
    @ResponseBody
    public String boardSearchPOST() throws Exception{
        System.out.println(" board 조회시작= ");
        List list = boardService.boardSearch();
        System.out.println("list = " + list);
        System.out.println(" board 조회끝= ");
        String json = new Gson().toJson(list);
        System.out.println("json = " + json);
        return json;
    }

    @RequestMapping("/board/register.do")
    @ResponseBody
    public String boardWrite(@RequestBody Map<String,String> map) throws Exception{
        BoardVO vo = new BoardVO();
        int cnt = boardService.serchbno() + 1;
        System.out.println("cnt = " + cnt);
        String title = map.get("title");
        String content = map.get("title");
        String writer = map.get("writer");
        String regdate = map.get("regdate");
        //String viewcnt = map.get("viewcnt");

        BoardVO boarddata = new BoardVO();
        boarddata.setBno(cnt);
        boarddata.setTitle(title);
        boarddata.setContent(content);
        boarddata.setWriter(writer);
        boarddata.setRegdate(regdate);
        boarddata.setViewcnt(0);
        boardService.boardWrite(boarddata);




        return "ok";
    }

    @RequestMapping("getbno.do")
    public String readBoard(@RequestBody Model model){
        Object test = model.getAttribute("bno");
        System.out.println("test = " + test);
        return "";
    }
}
