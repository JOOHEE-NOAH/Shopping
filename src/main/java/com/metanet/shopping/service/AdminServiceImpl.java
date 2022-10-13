package com.metanet.shopping.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.metanet.shopping.controller.AdminController;
import com.metanet.shopping.mapper.AdminMapper;
import com.metanet.shopping.model.AdminDto;
import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;

@Service
public class AdminServiceImpl implements AdminService{
	
	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);
	
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
		System.out.println("AdminService 도착햇쓔. 여기도 이미지리스트 잘 들어왓나 확인하고 리스트의 itemNo저장해줄게요");
		for (int i = 0; i < item.getImageList().size(); i++) {
			System.out.println(i+"번째 정보"+item.getImageList().get(i).getFileName());
			System.out.println(i+"번째 정보"+item.getImageList().get(i).getUuid());
			System.out.println("==================");
		}
		
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

//	@Override
//	public void insertItem(Map<String, Object> map, HttpServletRequest request) throws Exception {
//		
//		adminMapper.insertItem(map);
//		
//		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
//		for(int i=0, size=list.size(); i<size; i++){
//			adminMapper.insertFile(list.get(i));
//		}
//		
//		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
//		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
//		MultipartFile multipartFile = null;
//		while(iterator.hasNext()){
//			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
//			if(multipartFile.isEmpty() == false){
//				logger.debug("------------- file start -------------");
//				logger.debug("name : "+multipartFile.getName());
//				logger.debug("filename : "+multipartFile.getOriginalFilename());
//				logger.debug("size : "+multipartFile.getSize());
//				logger.debug("-------------- file end --------------\n");
//			}
//		}
//	}

}
