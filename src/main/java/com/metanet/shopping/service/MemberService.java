package com.metanet.shopping.service;

import java.util.Map;

import com.metanet.shopping.model.MemberDto;

public interface MemberService {
	//회원가입
	boolean memberJoin(MemberDto member) throws Exception;
	//아이디 중복체크
	int idCheck(String memberId);
	//로그인
	MemberDto login(MemberDto member);
	
}
