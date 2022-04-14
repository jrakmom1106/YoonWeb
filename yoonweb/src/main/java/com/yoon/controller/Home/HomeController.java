package com.yoon.controller.Home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller // 해당 controller가 붙은 모든것이 프로젝트가 실행될때 같이 mapping을 시켜준다고 생각하면된다.
public class HomeController {

    @RequestMapping("/**/*.view")
    public ModelAndView home(HttpServletRequest request) {
        ModelAndView view = new ModelAndView(request.getRequestURI().replace(".view", ""));
        return view;
    }



}