package com.metanet.shopping.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;
import com.metanet.shopping.model.MemberDto;
import com.metanet.shopping.model.Paging;
import com.metanet.shopping.service.ItemService;

@Controller
public class ShoppingController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private ItemService itemService;

	@RequestMapping(value = "/main", method = { RequestMethod.GET, RequestMethod.POST })
	public void mainPageGet(HttpServletRequest request,Model model) {
		logger.info("메인페이지 시작");
		List<ItemDto> itemList = itemService.itemList("all"); 		
		
		model.addAttribute("itemList",itemList);
	}

	/*
	 * 이미지는 로그인을 하든 안 하든 모든 곳에서 접근이 가능해야 하기 때문에 등록하는 것은 AdminController이지만, 이미지 가져오는
	 * 것은 ShoppingController에 작성함.
	 */
//	@GetMapping("/display")
//	public ResponseEntity<byte[]> getImage(String fileName) {
//		File file = new File("c:\\upload\\" + fileName);
//		
//		/* 'Content Type' 명시 & 데이터 파일 반환 */
//		
//		ResponseEntity<byte[]> result = null;
//		
//		try {
//			/*   ResponseEntity에 Response의 header와 관련된 설정의 객체를 추가해주기 위해서
//			  	 HttpHeaders를 인스턴스화 한 후 참조 변수를 선언하여 대입 */
//			HttpHeaders header = new HttpHeaders();
//			
//			// 대상 이미지 파일의 MIME TYPE을 얻기위해 probeContentType사용.
//			header.add("Content-type", Files.probeContentType(file.toPath()));//(속성명,속성명에 부여할 값)
//										  //복사 메서드 // 대상 파일을  Byte 배열로 반환//인자    //성공 상태(status) 코드 200이 전송
//			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
//
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//
//		return result;
//
//	}
	@RequestMapping(value = "/mainAll", method = { RequestMethod.GET, RequestMethod.POST })
	public String mainAll(@RequestParam("category") String category,ItemDto item, Model model, String currentPage, HttpServletRequest request, MemberDto member) {
		logger.info("메인 페이지 진입");

//		//전체상품 페이징 처리
		// int total = itemService.itemtotal();
		// System.out.println("MarketController total->"+total);
		// Paging pg = new Paging(total, currentPage);
		
		
		
		/*전체 상품 정보*/
		List<ItemDto> itemList = itemService.itemList(category); 		
		
		model.addAttribute("itemList",itemList);
		return "/mainAll";

	}
	
	@GetMapping("/itemDetail")
	public String itemDetail(@RequestParam("itemNo") int itemNo,Model model) {
		logger.info("상품상세페이지 진입");
		ItemDto itemDetail = itemService.itemDetail(itemNo);
		model.addAttribute("item",itemDetail);
		return "/item/itemDetail";
		
	}

}