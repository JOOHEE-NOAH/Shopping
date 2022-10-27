package com.metanet.shopping.mapper;

import java.util.List;

import com.metanet.shopping.model.ItemDto;

public interface ItemMapper {
	/* 전체상품 리스트 */
	List<ItemDto> itemAllList();
	/* 최신상품 리스트 */
	List<ItemDto> itemRecentList();
	/* 베스트상품 리스트 */
	List<ItemDto> itemBestList();
	/* 카테고리별 상품 리스트 */
	List<ItemDto> itemCategoryList(int itemCode);
	/* 상품상세정보 */
	ItemDto itemDetail(int itemNo);
	

}
