package com.metanet.shopping.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.metanet.shopping.mapper.MemberMapper;
import com.metanet.shopping.model.MemberDto;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper memberMapper;

	// 회원가입
	@Override
	public boolean memberJoin(MemberDto member) throws Exception {

		boolean chk;

		int result = memberMapper.memberJoin(member);
		if (result > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}

	// 아이디 중복검사
	@Override
	public int idCheck(String memberId) {
		int result = memberMapper.idCheck(memberId);
		return result;
	}

	// 로그인
	@Override
	public MemberDto login(MemberDto member) {
		member = memberMapper.login(member);
		return member;
	}

}
