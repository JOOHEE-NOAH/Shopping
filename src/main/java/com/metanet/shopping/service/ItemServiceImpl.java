package com.metanet.shopping.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.metanet.shopping.mapper.ItemImgMapper;
import com.metanet.shopping.mapper.ItemMapper;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;
@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemMapper itemMapper;
	
	@Autowired
	private ItemImgMapper itemImgMapper;

	/* 모든 상품 정보 */
	@Override
	public List<ItemDto> itemList(String category) {
		System.out.println("아이템서비스로 전달받은 카테고리->"+category);
		List<ItemDto> itemList = new ArrayList<ItemDto>(); 
		if (category.equals("all")) {
			System.out.println("전체상품 조회");
			itemList = itemMapper.itemAllList();
			System.out.println("전체 상품 개수 ->"+itemList.size());
		}else if (category.equals("recent")) {
			System.out.println("최신상품 조회");
			itemList = itemMapper.itemRecentList();
			System.out.println("전체 상품 개수 ->"+itemList.size());
		}else if (category.equals("best")) {
			System.out.println("베스트상품 조회");
			itemList = itemMapper.itemBestList();
			System.out.println("전체 상품 개수 ->"+itemList.size());
		}else {
			System.out.println("카테고리별상품 조회");
			int itemCode = Integer.parseInt(category);
			itemList = itemMapper.itemCategoryList(itemCode);
			System.out.println("카테고리"+itemCode+" 상품 개수 ->"+itemList.size());
		}
		
		
		itemList.forEach(item->{
			int itemNo = item.getItemNo();
			List<ItemImgDto> imageList = itemImgMapper.imageList(itemNo);
			item.setImageList(imageList);
		});
		
		return itemList;
	}

	/* 상품 상세정보 */
	@Override
	public ItemDto itemDetail(int itemNo) {
		ItemDto itemDetail = itemMapper.itemDetail(itemNo);
		List<ItemImgDto> imageList = itemImgMapper.imageList(itemNo);
		itemDetail.setImageList(imageList);
		System.out.println("상품 상세정보");
		System.out.println(itemDetail.toString());
		return itemDetail;
	}

}
