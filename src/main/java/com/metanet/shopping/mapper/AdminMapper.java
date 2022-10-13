package com.metanet.shopping.mapper;

import java.util.List;
import java.util.Map;

import com.metanet.shopping.model.AdminDto;
import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;

public interface AdminMapper {

	/* 관리자 로그인 */
	 AdminDto adminLogin(AdminDto admin);
	/* 상품종류 */
	List<ItemCodeDto> itemCodeList();
	/* 상품등록 */
	int itemRegister(ItemDto item);
	/* 파일등록 */
	void imgRegister(ItemImgDto itemImg);
	
//	void insertItem(Map<String, Object> map);
//	void insertFile(Map<String, Object> map);

}
