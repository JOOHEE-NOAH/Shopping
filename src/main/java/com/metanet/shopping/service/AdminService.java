package com.metanet.shopping.service;

import java.util.List;

import com.metanet.shopping.model.AdminDto;
import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;

public interface AdminService {
	//관리자 로그인
	AdminDto adminLogin(AdminDto admin);

	boolean itemRegister(ItemDto item);

	List<ItemCodeDto> itemCodeList();
	
}
