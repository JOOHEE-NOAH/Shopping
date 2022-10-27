package com.metanet.shopping.service;

import java.util.List;

import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;

public interface ItemService {

	//int itemtotal();
	
	/* 상품 리스트 */
	List<ItemDto> itemList(String category);

	ItemDto itemDetail(int itemNo);
	
//	/* 상품 상세 정보 */
//	ItemDto itemDetail(int itemNo);

}
