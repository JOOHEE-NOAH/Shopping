package com.metanet.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.metanet.shopping.mapper.ItemImgMapper;
import com.metanet.shopping.model.ItemImgDto;

@Service
public class ItemImgServiceImpl implements ItemImgService {
	@Autowired
	ItemImgMapper itemImgMapper;

	@Override
	public List<ItemImgDto> imageList(int itemNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
