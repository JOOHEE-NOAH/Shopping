package com.metanet.shopping.mapper;

import java.util.List;

import com.metanet.shopping.model.ItemImgDto;

public interface ItemImgMapper {
	/* 상품 이미지 정보 */
	List<ItemImgDto> imageList(int itemNo);

}
