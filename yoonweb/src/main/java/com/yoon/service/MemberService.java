package com.yoon.service;

import com.yoon.model.MemberVO;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface MemberService {
    public void memberJoin(MemberVO member) throws Exception;
    public Map<String, String> memberFind(Map<String,String> map) throws Exception;
    public int idCheck(String memberId) throws Exception;

    public List memberAutoComplete(Map<String,String> mapData) throws SQLException, Exception;
    public List ArrayListSample(List<Map<String,String>> mapList) throws SQLException, Exception;

    public int checkMemeber(Map<String,String> mapData) throws SQLException, Exception;

}
