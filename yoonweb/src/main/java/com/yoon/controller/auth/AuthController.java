package com.yoon.controller.auth;

import com.yoon.model.MemberVO;
import com.yoon.service.MemberService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AuthController {


    @Autowired
    private MemberService memberservice;


    // 회원가입
    @RequestMapping(value="/auth/authjoin.do", method= RequestMethod.POST)
    @ResponseBody
    public String JoinAuth(@RequestBody Map<String,String> map) throws Exception{


        String ID = map.get("ID");
        String PW = map.get("PW");
        MemberVO member = new MemberVO();
        System.out.println("ID = " + ID);

        member.setMemberId(ID);			//회원 id
        member.setMemberPw(PW);			//회원 비밀번호

        System.out.println("jsonElement\n = " + map);

        memberservice.memberJoin(member);
        return "";
    }


    //아이디 중복검사
    @RequestMapping("/join/authjoincheck.do")
    @ResponseBody
    public HashMap<String, Object> memberIdChkPOST(@RequestBody Map<String,String> map) throws Exception{
        System.out.println("memberId 테스트 = " + map);
        String memberId = map.get("memberId");
        System.out.println("memberId 테스트 = " + memberId);

        int result = memberservice.idCheck(memberId);


        HashMap<String, Object> resultMap = new HashMap<String, Object>();


        if(result != 0) {
            resultMap.put("state", "fail");
            // 중복 아이디가 존재
        } else {
            resultMap.put("state", "success");
            // 중복 아이디 x
        }

        JSONObject returnresult = new JSONObject(resultMap);
        return returnresult;
    }

    @RequestMapping("/join/authlogin.do")
    @ResponseBody
    public Boolean loginAuth(@RequestBody Map<String,String> map) throws Exception {

        String Id =map.get("memberId");
        String Pw =map.get("memberPw");

        Map result = memberservice.memberFind(map);
        //Object test1 = result.get("MEMBERPW");
        //System.out.println("result = " + test1);
        System.out.println("result = " + result);
        if(result != null){
            return true;
        }else{
            return false;
        }

    }

    //자동완성 기능
    @RequestMapping("member/memberAutoComplete.do")
    @ResponseBody
    public List memberAutoComplete(@RequestBody Map<String,String> mapData) throws Exception{

        System.out.println("autoComplete 실행");
        System.out.println(mapData);
        System.out.println(mapData.get("VALUE"));
        ModelAndView mav = new ModelAndView();

        List resultList = memberservice.memberAutoComplete(mapData);


        mav.addObject("output",resultList);

        return resultList;

    }

    //list value sample
    @RequestMapping("member/ArrayListSample.do")
    @ResponseBody
    public int ArrayListSample(@RequestBody List<Map<String,String>> mapList) throws Exception{

        System.out.println("ArrayListSample 실행");
        System.out.println(mapList);

        for(int i = 0 ; i > mapList.size(); i++){

            System.out.println(mapList.get(i));

        }

        ModelAndView mav = new ModelAndView();

        int resultList = memberservice.ArrayListSample(mapList);


        mav.addObject("output",resultList);

        return resultList;

    }

    //list value sample
    @RequestMapping("member/checkMemeber.do")
    @ResponseBody
    public int checkMemeber(@RequestBody Map<String,String> mapData) throws Exception{

        System.out.println("checkMemeber 실행");
        System.out.println(mapData);

        ModelAndView mav = new ModelAndView();

        int resultCnt = memberservice.checkMemeber(mapData);


        mav.addObject("output",resultCnt);

        return resultCnt;

    }

}
