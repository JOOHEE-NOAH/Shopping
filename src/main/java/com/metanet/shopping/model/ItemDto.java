package com.metanet.shopping.model;

import java.util.List;

import lombok.Data;

@Data
public class ItemDto {
	/* 상품번호 */
	private int itemNo;
	/* 상품명 */
	private String itemName;
	/* 상품종류 */
	private int itemCode;
	/* 재고 */
	private int itemAmount;
	/* 원가 */
	private int itemCost;
	/* 판매가 */
	private int itemPrice;
	/* 할인율 */
	private int itemDiscount;
	/* 상품설명 */
	private String itemContents;
	/* 상품 삭제여부 */
	private int itemStatus;
	/* 상품 등록일 */
	private String itemRegDate;
	
	/* 상품 이미지 정보 */
	private List<ItemImgDto> imageList;
}
