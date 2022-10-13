package com.metanet.shopping.model;

import lombok.Data;

@Data
public class ItemImgDto {
	/* 상품번호 */
	private int itemNo; 
	/* 파일명 */
	private String fileName;
	/* uuid */
	private String uuid;
}
