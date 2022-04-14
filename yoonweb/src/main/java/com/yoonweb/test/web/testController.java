package com.yoonweb.test.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Controller
public class testController {

    @RequestMapping(value = "/test/testList.do", method = RequestMethod.POST)
    public @ResponseBody
    Object testList(@RequestBody Map<String, Object> body) throws Exception {
        if (body != null) {
            body.put("response", "response data");
        }

        return body;
    }

    @RequestMapping(value = "/test/testList2.do", method = RequestMethod.PUT)
    public @ResponseBody
    Object testList2(@RequestBody Map<String, Object> body) throws Exception {
        if (body != null) {
            body.put("response", "response data2");
        }

        return body;
    }

    @RequestMapping(value = "/test/testList3.do", method = RequestMethod.POST)
    public @ResponseBody
    Object testList3(@RequestBody Map<String, Object> body) throws Exception {
        if (body != null) {
            String username = (String) body.get("name");
            String age = (String) body.get("age");

            if (age.equals("10")) {
                body.put("rule", "N");
            }

            if (username.equals("admin")) {
                body.put("auth", "Y");
            } else if (username.equals("tester")) {
                body.put("auth", "T");
            } else {
                body.put("auth", "N");
            }


        }

        return body;
    }

    @RequestMapping("/test/tab2.do")
    public String tab() {
        return "tabmanager/tab2.viw";
    }

    @RequestMapping("/test/popup.do")
    public  String pop() {
        return "popup/popuptest";
    }

}
