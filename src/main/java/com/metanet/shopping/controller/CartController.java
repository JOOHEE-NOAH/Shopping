package com.metanet.shopping.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.metanet.shopping.model.CartDto;
import com.metanet.shopping.model.MemberDto;
import com.metanet.shopping.service.CartService;
import com.metanet.shopping.service.MemberService;

@Controller
@RequestMapping(value = "/cart") // member관련 기능을 수행하는지 구분해 주기위해 url 경로에 member 거치도록 어노테이션으로 설계.
public class CartController {

	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService cartService;

	/* 장바구니에 추가 */
	@PostMapping("/insertCart")
	@ResponseBody
	public String insertCart(CartDto cart, HttpServletRequest request) {
		logger.info("장바구니 추가 컨트롤러 시작");
		/* (0 : 등록 실패 / 1 : 등록 성공 / 2 : 등록된 데이터 존재 / 3 : 로그인 필요) */
		// 장바구니추가 실패했을 경우 0을 반환하기위해 throws Exception 사용
		System.out.println("넘어온 값 확인해 볼까요?");
		System.out.println(cart.toString());
		String result = "0";
		// 1.로그인 확인
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		if (member == null) {// 로그인 하지 않았을 시
			result = "3";
			
		} else if(member != null) {
			// 2.장바구니 추가
			result = Integer.toString(cartService.insertCart(cart));
		}
		System.out.println(result);
		return result;
	}

//	/* 장바구니 삭제 */
//	public int deleteCart(int cartNo);
//

	/* 장바구니 목록 */
	@GetMapping("/memberCartList/{memberId}")
	public String memberCartList(@PathVariable("memberId") String memberId, Model model) {
		System.out.println("memberId잘 받았나요?->"+memberId);
		/* 사용자의 장바구니 리스트 정보 */
		List<CartDto> cartList = cartService.memberCartList(memberId);
		
		System.out.println("itemList.size()-> "+cartList.size());
		
		model.addAttribute("cartList",cartList);
		return "/cart";
	}

	/* 장바구니 수량 변경 */
	@PostMapping("changeItemCount")
	public String update(CartDto cart, HttpServletRequest request,@RequestParam("itemCount") String itemCountcome,@RequestParam("cartNo") String cartNoInput) {
		cart.setCartNo(Integer.parseInt(cartNoInput));
		cart.setItemCount(Integer.parseInt(itemCountcome));
		cartService.changeItemCount(cart);
		
		return "redirect:/cart/memberCartList/" + cart.getMemberId();
		
	}
	
	/* 장바구니 삭제 */
	@PostMapping("deleteCart")
	public String deleteCart(CartDto cart) {
		System.out.println("삭제시작");
		System.out.println("받은 카트 넘버->"+cart.getCartNo());
		cartService.deleteCart(cart.getCartNo());
		return "redirect:/cart/memberCartList/" + cart.getMemberId();
	}
	
	
	
//	/* 이미 해당 상품 담았는지 안담았는지 확인 */
//	public CartDto cartChk(CartDto cart);

}
