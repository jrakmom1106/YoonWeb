package com.yoon.controller;

import com.yoon.model.MemberVO;
import com.yoon.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

public class MemberController {

        @Autowired
        private MemberService memberservice;
        //회원가입
        @RequestMapping(value="/join", method= RequestMethod.POST)
        public String joinPOST(MemberVO member) throws Exception{

                System.out.println("member = " + member);
                // 회원가입 서비스 실행
                memberservice.memberJoin(member);

                return "redirect:/main";

        }




        }
