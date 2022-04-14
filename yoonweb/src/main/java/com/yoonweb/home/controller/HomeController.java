package com.yoonweb.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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


//annotation,
//15:47:50.061 [RMI TCP Connection(3)-127.0.0.1] DEBUG org.springframework.beans.factory.support.DefaultListableBeanFactory - Creating shared instance of singleton bean 'org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping'
//15:47:49.805 [RMI TCP Connection(3)-127.0.0.1] DEBUG org.springframework.context.annotation.ClassPathBeanDefinitionScanner - Identified candidate component class: file [C:\yoonweb\target\yoonweb-0.0.1-SNAPSHOT\WEB-INF\classes\com\yoonweb\home\controller\HomeController.class]