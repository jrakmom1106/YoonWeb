package com.yoon.service;

import com.yoon.mapper.MemberMapper;
import com.yoon.model.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
    public class MemberServiceImpl implements MemberService{

        @Autowired
        MemberMapper membermapper;

        @Override
        public void memberJoin(MemberVO member) throws Exception {

            membermapper.memberJoin(member);

        }

        @Override
        public Map<String,String>memberFind(Map<String,String> map) throws Exception {

            return membermapper.memberFind(map);

        }

    @Override
    public int idCheck(String memberId) throws Exception {

        return membermapper.idCheck(memberId);
    }

    }

