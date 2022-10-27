package com.metanet.shopping.model;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Data
public class CartDto {
	/* 장바구니번호 */
	private int cartNo;
	/* 회원아이디 */
	private String memberId;
	/* 상품번호 */
	private int itemNo;
	/* 수량 */
	private int itemCount;
	
	
	/* 참조테이블 */
	private String itemName;
	/* 상품종류 */
	private int itemCode;
	/* 상품 재고 */
	private int itemAmount;
	/* 판매가 */
	private int itemPrice;
	/* 할인율 */    
	private double itemDiscount;
	/* 삭제여부 */
	private int itemStatus;
	/* 상품이미지 */
	private List<ItemImgDto> imageList;
	
	
	
	//추가
	/* itemPrice에 itemDiscount할인율 적용한 제품 1개 금액 */
	private int discountPrice;
	/* 판매가,할인율,수량 적용한 총금액 */
	private int totalPrice;
	/* 1개의 포인트 */
	private int point;
	/* 장바구니에 담은 수량* 1개의 포인트 */
	private int totalPoint;
	
	public void priceCal() {
		this.discountPrice = (int) (this.itemPrice*(1-this.itemDiscount/100));
		this.totalPrice = this.discountPrice*this.itemCount;
		this.point = (int)(Math.floor(this.discountPrice*0.05));
		this.totalPoint = this.point*this.itemCount;
		
	}
}
