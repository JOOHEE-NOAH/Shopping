package com.metanet.shopping.mapper;

import java.util.List;

import com.metanet.shopping.model.CartDto;

public interface CartMapper {
	/* 장바구니에 추가 */
	public int insertCart(CartDto cart) throws Exception;
	//insertCart 실패했을 경우 0을 반환하기위해 throws Exception 사용
	
	/* 장바구니 삭제 */
	public int deleteCart(int cartNo);
	
	/* 장바구니 목록 */
	public List<CartDto> memberCartList(String memberId);
	
	/* 이미 해당 상품 담았는지 안담았는지 확인 */
	public CartDto cartChk(CartDto cart);
	
	/* 장바구니 수량 변경 */
	public int changeItemCount(CartDto cart);

	

	

	

	
}
