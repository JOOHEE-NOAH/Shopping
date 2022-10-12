package com.metanet.shopping.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.metanet.shopping.model.MemberDto;
import com.metanet.shopping.service.MemberService;

@Controller
@RequestMapping(value = "/member") // member관련 기능을 수행하는지 구분해 주기위해 url 경로에 member 거치도록 어노테이션으로 설계.
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	// 회원가입 페이지로 이동
	@GetMapping("/joinForm")
	public void joinForm() {
		logger.info("회원가입 페이지로 진입");
	}

	// 회원가입
	@PostMapping("/join")
	public String join(MemberDto member, Model model) throws Exception {

		logger.info("post회원가입 진입");
		boolean chk = memberService.memberJoin(member);
		logger.info("회원가입 성공");
		System.out.println("결과->" + chk);

		model.addAttribute("chk", chk);

		return "/member/join";

	}

	// 아이디 중복검사
	@GetMapping("/idCheck")
	@ResponseBody // joinForm.jsp로 메서드의 결과가 반환하기위해 사용
	public String idcheck(String memberId) {
		String chk = "";
		int result = 0;
		result = memberService.idCheck(memberId);
		if (result == 1) {
			chk = "redundancy"; // 아이디 중복
		} else if (result == 0) {
			chk = "noredundancy"; // 아이디 중복아님
		}
		return chk;
	}

	// 로그인 페이지로 이동
	@RequestMapping(value = "/loginForm", method = { RequestMethod.GET, RequestMethod.POST })
	public void loginForm() {
		logger.info("로그인 페이지로 진입");
	}

	// 로그인
	@PostMapping("/login")
	@ResponseBody // loginForm.jsp로 메서드의 결과가 반환하기위해 사용
	public String login(MemberDto member, HttpServletRequest request) {
		logger.info("로그인 진입");

		HttpSession session = request.getSession();

		// 기존에 member라는 session값이 존재하면 remove
		if (session.getAttribute("member") != null) {
			session.removeAttribute("member");
		}
		// 기존에 admin session값 존재하면 remove
		if (session.getAttribute("admin") != null) {
			session.removeAttribute("admin");
		}

		String result = "";
		MemberDto loginMember = memberService.login(member);

		// 일치하는 아이디,비번 불일치
		if (loginMember == null) {
			result = "fail";
			// return result;
		} else {
			if (loginMember.getMemberStatus() == 0) {
				System.out.println("탈퇴회원인지 확인-> 상태" + loginMember.getMemberStatus());
				// 탈퇴회원
				result = "withdraw";
			} else if (loginMember.getMemberStatus() == 1) {
				// 아이디,비밀번호 일치 시 세션에 로그인 정보 담기
				session.setAttribute("member", loginMember);
				result = "success";
			}
		}
		System.out.println("result->" + result);
		return result;

	}
	
	//로그아웃
	@PostMapping("/logout")
	@ResponseBody
	public void logout(HttpServletRequest request){
		logger.info("회원 로그아웃 진입");
		HttpSession session = request.getSession();
		session.invalidate();
	}

}
