package com.yoon.model;

public class MemberVO {
    private String memberId;

    @Override
    public String toString() {
        return "MemberVO{" +
                "memberId='" + memberId + '\'' +
                ", memberPw='" + memberPw + '\'' +
                '}';
    }

    private String memberPw;

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberPw() {
        return memberPw;
    }

    public void setMemberPw(String memberPw) {
        this.memberPw = memberPw;
    }
}
