package com.metanet.shopping.service;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.metanet.shopping.mapper.AdminMapper;
import com.metanet.shopping.model.AdminDto;
import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminMapper adminMapper;

	// 로그인
	@Override
	public AdminDto adminLogin(AdminDto admin) {
		admin = adminMapper.adminLogin(admin);
		return admin;
	}
	
	//상품등록
	@Override
	public boolean itemRegister(ItemDto item) {
		boolean chk;

		int result = adminMapper.itemRegister(item);
		//해당 item등록 시 itemImg 리스트의 itemNo에 item객체에서 받은 itemNo 넣어주기
		for(ItemImgDto itemImg : item.getImageList()) {
			itemImg.setItemNo(item.getItemNo());
			adminMapper.imgRegister(itemImg);
		}
		if (result > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}
	//상품카테고리 목록
	@Override
	public List<ItemCodeDto> itemCodeList() {
		List<ItemCodeDto> itemCodeList =null;
		itemCodeList = adminMapper.itemCodeList();
		return itemCodeList;
	}

}
