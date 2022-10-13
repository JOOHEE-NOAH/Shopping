package com.metanet.shopping.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminServiceTest {
	@Autowired
	AdminService service;
	
	//상품등록 상품이미지 등록
	@Test
	public void itemRegisterTest() {
		ItemDto item = new ItemDto();
		// 상품 정보
		item.setItemName("inputtest");
		item.setItemCode(1);
		item.setItemAmount(5);
		item.setItemCost(1000);
		item.setItemPrice(5000);
		item.setItemDiscount(10);
		item.setItemContents("inputtest");

		// 이미지 정보
		List<ItemImgDto> imgList = new ArrayList<ItemImgDto>(); 
		
		ItemImgDto image1 = new ItemImgDto();
		ItemImgDto image2 = new ItemImgDto();
		
		image1.setFileName("test Image 1");
		image1.setUuid("inputtest1111");
		
		image2.setFileName("test Image 2");
		image2.setUuid("inputtest2222");
		
		imgList.add(image1);
		imgList.add(image2);
		
		item.setImageList(imgList);        
		
		// itemEnroll() 메서드 호출
		service.itemRegister(item);
		
		System.out.println("등록된 Dto : " + item);
	}

}
