package com.metanet.shopping.service;

import java.util.List;

import com.metanet.shopping.model.CartDto;

public interface CartService {
	/* 장바구니에 추가 */
	public int insertCart(CartDto cart);
	/* 장바구니 목록 */
	public List<CartDto> memberCartList(String memberId);
	/* 장바구니 수량 변경 */
	public int changeItemCount(CartDto cart);
	/* 장바구니 삭제 */
	public int deleteCart(int cartNo);
	
}
