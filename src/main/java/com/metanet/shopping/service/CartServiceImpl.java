package com.metanet.shopping.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.metanet.shopping.controller.CartController;
import com.metanet.shopping.mapper.CartMapper;
import com.metanet.shopping.mapper.ItemImgMapper;
import com.metanet.shopping.model.CartDto;
import com.metanet.shopping.model.ItemImgDto;

@Service
public class CartServiceImpl implements CartService {
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private ItemImgMapper itemImgMapper;

	// 장바구니에 추가
	@Override
	public int insertCart(CartDto cart) {
		logger.info("장바구니 추가 serviceImpl 시작");
		System.out.println(cart.getMemberId());
		System.out.println(cart.getItemNo());
		System.out.println(cart.getItemCount());
		
		// 장바구니에 추가 전, 이미 장바구니에 담겨있는지 확인.
		CartDto cartChk = cartMapper.cartChk(cart);

		// 이미 장바구니 테이블에 담겨있는경우 2 return
		if (cartChk != null) {
			return 2;
		}

		try {// 장바구니 등록
			return cartMapper.insertCart(cart);
		} catch (Exception e) {
			// 등록에러 시 0반환
			return 0;
		}
		
	}

	/* 장바구니 목록 */
	@Override
	public List<CartDto> memberCartList(String memberId) {
		List<CartDto> cartList = cartMapper.memberCartList(memberId);
		
		/*discountPrice,totalPrice, point, totalPoint는 현재 값이 없음.
		priceCal을 호출해주어야 값이 세팅 됨. cartList로 가져온 요소들 중 위 4개를 초기화해주기*/ 
		for(CartDto cart : cartList) {
			cart.priceCal();
			
			/* 상품 이미지 */
			int itemNo = cart.getItemNo();
			List<ItemImgDto> imageList = itemImgMapper.imageList(itemNo);
			cart.setImageList(imageList);
		}
		
		return cartList;
	}

	/* 장바구니 수량 변경 */
	@Override
	public int changeItemCount(CartDto cart) {
		return cartMapper.changeItemCount(cart);
	}

	/* 장바구니 삭제 */
	@Override
	public int deleteCart(int cartNo) {
		return cartMapper.deleteCart(cartNo);
	}

}
