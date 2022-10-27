package com.metanet.shopping.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.metanet.shopping.model.MemberDto;

public class CartInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// "/cart/**" url을 이용하는 사용자가 요청을 하였을 때 Controller로 요청이 가기 전 요청자가 로그인을 하였는지 확인
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");

		if (member == null) {
			response.sendRedirect("/main");
			return false;
		} else {
			return true;
		}
	}

}
