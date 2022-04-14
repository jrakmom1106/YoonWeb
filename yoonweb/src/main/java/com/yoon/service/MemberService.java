package com.yoon.service;

import com.yoon.model.MemberVO;

import java.util.List;
import java.util.Map;

public interface MemberService {
    public void memberJoin(MemberVO member) throws Exception;
    public Map<String, String> memberFind(Map<String,String> map) throws Exception;
    public int idCheck(String memberId) throws Exception;
}
