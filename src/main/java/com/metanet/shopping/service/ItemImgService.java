package com.metanet.shopping.service;

import java.util.List;

import com.metanet.shopping.model.ItemImgDto;

public interface ItemImgService {
	/* 상품 이미지 정보 */
	List<ItemImgDto> imageList(int itemNo);
}
