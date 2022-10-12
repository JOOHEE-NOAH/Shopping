package com.metanet.shopping.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminMapperTest {
	@Autowired
	private AdminMapper adminmapper;
	
//	@Test
//    public void login() throws Exception{
//        
//        AdminDto admin = new AdminDto();    // adminVO 변수 선언 및 초기화
//        
//        /* 올바른 아이디 비번 입력경우 */
//        admin.setAdminId("admin");
//        admin.setAdminPw("123");
//        
//        /* 올바른 않은 아이디 비번 입력경우 */
////        admin.setadminId("test1123");
////        admin.setadminPw("test1321321");
//        
//        adminmapper.adminLogin(admin);
//        System.out.println("결과 값 : " + adminmapper.adminLogin(admin));
//        
//    }
	
	@Test
    public void itemRegister() throws Exception{
        
		ItemDto item = new ItemDto();
        
		item.setItemName("item3");
		item.setItemCode(3);
		item.setItemAmount(10);
		item.setItemCost(10000);
		item.setItemPrice(13000);
		item.setItemDiscount(10);
		item.setItemContents("item3 contents");
		
		System.out.println("Before Item"+ item);
        adminmapper.itemRegister(item);
        System.out.println("After Item"+ item);
    }
	
//	@Test
//	public void itemCodeList() throws Exception{
//		adminmapper.itemCodeList();
//	}
	
//	@Test
//	public void imgRegister() throws Exception{
//		ItemImgDto itemImg = new ItemImgDto();
//		
//		itemImg.setItemNo(2);
//		itemImg.setFileName("test2");
//		itemImg.setUploadPath("test2path");
//		itemImg.setUuid("test2path");
//		
//		adminmapper.imgRegister(itemImg);
//	}
}
