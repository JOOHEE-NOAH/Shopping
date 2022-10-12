package com.metanet.shopping.model;

import lombok.Data;

@Data
public class ItemImgDto {
	/* 상품번호 */
	private int itemNo; 
	/* 파일명 */
	private String fileName;
	/* 파일 경로 */
	private String uploadPath;
	/* uuid */
	private String uuid;
}
