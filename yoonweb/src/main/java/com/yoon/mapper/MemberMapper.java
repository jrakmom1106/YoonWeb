package com.yoon.mapper;

import com.yoon.model.MemberVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MemberMapper {

    public void memberJoin(MemberVO member);
    Map<String, String>memberFind(Map<String, String> map);
    public int idCheck(String memberId);
    public List memberAutoComplete(Map<String,String> mapData);
    public int ArrayListSample(List<Map<String,String>> mapList);

    public int checkMemeber(Map<String,String> mapData);

}
