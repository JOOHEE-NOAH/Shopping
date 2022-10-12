package com.metanet.shopping.mapper;

import com.metanet.shopping.model.MemberDto;

public interface MemberMapper {
	//회원가입
	public int memberJoin(MemberDto member);
	//아이디 중복체크
	public int idCheck(String memberId);
	//로그인
	//public MemberVo login(MemberVo member);
	public MemberDto login(MemberDto member);

}
