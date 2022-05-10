package com.yoon.controller.Menu;

import com.google.gson.Gson;
import com.yoon.model.BoardVO;
import com.yoon.service.BoardService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;


@Controller
public class MenuController {

    @Autowired
    private BoardService boardService;

    @RequestMapping("/menu/menu1.do")
    public String menu1() {
        return "menu/menu1";
    }

    @RequestMapping("/menu/menu2.do")
    public String menu2() {
        return "menu/menu2";
    }

    @RequestMapping("/menu/menu3.do")
    public String menu3() {
        return "menu/menu3";
    }

    @RequestMapping("auth/authjoin.do")
    public String authJoin() {
        return "join/authjoin";
    }

    @RequestMapping("/regi/loader.do")
    public String regi() {
        return "/menu/boardregister";
    }

    @RequestMapping("/board/selectboarddetail.do")
    public ModelAndView detail(@RequestParam Map<String, String> map) {
        System.out.println("상세조회 진입");

        String title = map.get("title");
        String content = map.get("content");
        String writer = map.get("writer");
        String regdate = map.get("regdate");
        String bnostring = map.get("bno");
        String filename = map.get("filename");
        String filerealname = map.get("filerealname");

        Integer bno = Integer.parseInt(bnostring);

        ModelAndView mv = new ModelAndView("menu/boardselect");
        mv.addObject("title", title);
        mv.addObject("content", content);
        mv.addObject("writer", writer);
        mv.addObject("regdate", regdate);
        mv.addObject("bno",bno);
        mv.addObject("filename",filename);
        mv.addObject("filerealname",filerealname);

        return mv;


    }

    @RequestMapping("/board/updateboard.do")
    public ModelAndView Updateboard(@RequestParam Map<String, String> map) throws Exception {
        System.out.println("수정화면 진입");

        String title = map.get("title");
        String content = map.get("content");
        String regdate = map.get("regdate");
        String bnostring = map.get("bno");
        Integer bno = Integer.parseInt(bnostring);

        List result = boardService.selectBoard(bno);

        System.out.println("resulthere = " + result);

        String resultst = result.get(0).toString();
        System.out.println("resultst = " + resultst);

        String json = new Gson().toJson(result);
        System.out.println("json = " + json);


        ModelAndView mv = new ModelAndView("menu/updateboard");
        mv.addObject("title", title);
        mv.addObject("content", content);
        mv.addObject("regdate", regdate);
        mv.addObject("bno",bno);
        mv.addObject("json" , json);

        return mv;
    }


}
