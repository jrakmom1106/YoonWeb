package com.yoon.controller.board;

import com.google.gson.Gson;
import com.yoon.model.BoardVO;
import com.yoon.service.BoardService;
import org.apache.commons.io.FilenameUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping(value = "/board/search.do", produces = "application/text; charset=utf8")
    @ResponseBody
    public String boardSearchPOST(@RequestBody Map<String, String> map) throws Exception{
        System.out.println(" board 조회시작= ");
        Integer viewcnt = Integer.parseInt(map.get("view"));
        Integer nowpage = Integer.parseInt(map.get("pagenum"));
        
        String title = map.get("title");
        System.out.println("title = " + title);
        String writer = map.get("writer");
        System.out.println("writer = " + writer);


        Integer start = viewcnt * (nowpage-1) +1;
        Integer last = start + viewcnt -1;

        System.out.println("start + last = " + start + last);

        List list = boardService.boardSearch(start,last,writer,title);


        System.out.println("list = " + list);
        System.out.println(" board 조회끝= ");
        String json = new Gson().toJson(list);
        System.out.println("json = " + json);
        return json;
    }

    @RequestMapping("/board/register.do")
    @ResponseBody
    public String boardWrite(MultipartHttpServletRequest req) throws Exception{
        System.out.println("게시글 등록 시작");

        String title = req.getParameter("subject");
        System.out.println("title = " + title);
        String content = req.getParameter("content");
        System.out.println("content = " + content);
        String writer = req.getParameter("writer");
        System.out.println("writer = " + writer);
        String date = req.getParameter("date");
        System.out.println("date = " + date);


        MultipartFile file = req.getFile("filename");
        System.out.println("file =" + file);
        String filename = "";


        // file 첨부여부 확인
        if(!file.isEmpty()){
            System.out.println("비어있지 않음");

        String originname = file.getOriginalFilename();
        System.out.println("originname = " + originname);

        String ext = FilenameUtils.getExtension(originname);
        System.out.println("ext = " + ext);

        UUID uuid = UUID.randomUUID();
        filename = uuid + "."+ext;
        file.transferTo(new File("C:\\filetest\\" + filename));

        }

        BoardVO boarddata = new BoardVO();

        int cnt = boardService.serchbno() + 1;

        boarddata.setBno(cnt);
        boarddata.setTitle(title);
        boarddata.setContent(content);
        boarddata.setWriter(writer);
        boarddata.setRegdate(date);
        boarddata.setViewcnt(0);
        boarddata.setFilename(filename);
        boardService.boardWrite(boarddata);

        return "ok";
    }

    @RequestMapping("getbno.do")
    public String readBoard(@RequestBody Model model){
        Object test = model.getAttribute("bno");
        System.out.println("test = " + test);
        return "";
    }

    @RequestMapping("/board/boardcount.do")
    @ResponseBody
    public Integer searchcount(@RequestBody Map<String, String> map) throws Exception{
        System.out.println("검색 총 수 파악");
        String writer = map.get("writer");
        System.out.println("writer = " + writer);
        String title = map.get("title");
        System.out.println("title = " + title);

        Integer result = boardService.searchcnt(writer,title);
        System.out.println("result = " + result);
        return result;
    }

    @RequestMapping(value="/board/selectboard.do", produces = "application/text; charset=utf8")
    @ResponseBody
    public String selectBoard(@RequestBody Map<String, String> map) throws Exception {
        System.out.println("상세화면 조회 시작");

        String data = map.get("bno");
        System.out.println("data = " + data);
        Integer bno = Integer.parseInt(data);
        List result = boardService.selectBoard(bno);
        System.out.println("result = " + result);
        //json 변환
        String json = new Gson().toJson(result);
        return json;
    }

    @RequestMapping("/board/remove.do")
    @ResponseBody
    public void removeBoard(@RequestBody Map<String, String> map) throws Exception{
        String stringbno = map.get("bno");
        Integer bno = Integer.parseInt(stringbno);

        boardService.boardRemove(bno);

    }

    @RequestMapping("/board/update.do" )
    @ResponseBody
    public void updateBoard(@RequestBody Map<String,String> map )throws Exception{
        System.out.println("업데이트 진입");

        String title = map.get("title");
        System.out.println("title = " + title);
        String content = map.get("content");
        System.out.println("content = " + content);
        String Stringbno = map.get("bno");
        System.out.println("Stringbno = " + Stringbno);
        
        Integer bno = Integer.parseInt(Stringbno);

        boardService.boardUpdate(title,content,bno);


    }
}
