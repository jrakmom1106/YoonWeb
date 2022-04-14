package com.yoon.controller.Menu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MenuController {

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
    public String authJoin() {return "join/authjoin";}
    @RequestMapping("/regi/loader")
    public String regi(){
        return "crud/register";
    }

}
