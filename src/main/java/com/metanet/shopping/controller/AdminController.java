package com.metanet.shopping.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.metanet.shopping.model.AdminDto;
import com.metanet.shopping.model.ItemCodeDto;
import com.metanet.shopping.model.ItemDto;
import com.metanet.shopping.model.ItemImgDto;
import com.metanet.shopping.service.AdminService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping(value = "/admin") // admin관련 기능을 수행하는지 구분해 주기위해 url 경로에 admin 거치도록 어노테이션으로 설계.
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	private static String CURR_IMAGE_REPO_PATH = "c:\\spring\\image_repo";

	@Autowired
	private AdminService adminService;

	// 관리자로그인 페이지로 이동
	@RequestMapping(value = "/adminLoginForm", method = { RequestMethod.GET, RequestMethod.POST })
	public void loginForm() {
		logger.info("관리자로그인 페이지로 진입");
	}

	// 관리자로그인
	@PostMapping("/adminLogin")
	@ResponseBody // loginForm.jsp로 메서드의 결과가 반환하기위해 사용
	public String login(AdminDto admin, HttpServletRequest request) {
		logger.info("관리자 로그인 진입");

		HttpSession session = request.getSession();

		// 기존에 member라는 session값이 존재하면 remove
		if (session.getAttribute("member") != null) {
			session.removeAttribute("member");
		}
		// 기존에 admin session값 존재하면 remove
		if (session.getAttribute("admin") != null) {
			session.removeAttribute("admin");
		}

		String result = "";
		AdminDto loginAdmin = adminService.adminLogin(admin);

		// 일치하는 아이디,비번 불일치
		if (loginAdmin == null) {
			result = "fail";
		} else {
			// 아이디,비밀번호 일치 시 세션에 로그인 정보 담기
			session.setAttribute("admin", loginAdmin);
			result = "success";
		}
		return result;

	}

	// 로그아웃
	@PostMapping("/adminLogout")
	@ResponseBody
	public void logout(HttpServletRequest request) {
		logger.info("관리자 로그아웃 진입");
		HttpSession session = request.getSession();
		session.invalidate();
	}

	// 상품등록 페이지
	@GetMapping("/itemRegisterForm")
	public String itemRegisterForm(Model model) {
		logger.info("상품등록 페이지 진입");
		// 상품카테고리 뽑기
		List<ItemCodeDto> itemCodeList = adminService.itemCodeList();
		model.addAttribute("itemCodeList", itemCodeList);
		return "/item/itemRegisterForm2";
	}

	// 상품등록4
	@RequestMapping(value = "itemRegister")
	public String itemRegister(ItemDto item, Model model, MultipartHttpServletRequest mtfRequest,
			HttpServletRequest request) {

		/* 사진 업로드하기*/		
		// 사진저장할 서버의 물리적경로.
		//C:\java programming\Sources\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Shopping\resources\images
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		System.out.println("사진 저장할 경로?");
		System.out.println(uploadPath);
		List<MultipartFile> fileList = mtfRequest.getFiles("file");

		// file input시 입력된 값만 UUID 지정해주기
		List<String> UUIDlist = new ArrayList<String>();
		for (int i = 0; i < fileList.size(); i++) {
			if (!fileList.get(i).getOriginalFilename().equals("")) {
				try {
					UUIDlist.add(
							uploadFile(fileList.get(i).getOriginalFilename(), fileList.get(i).getBytes(), uploadPath));
				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (fileList.get(i).getOriginalFilename().equals("")) {
				UUIDlist.add(""); // input된 file값이 없을 시, DB null이 되도록 처리.
			}
		}

		List<ItemImgDto> imgList = new ArrayList<ItemImgDto>();
		for (int i = 0; i < fileList.size(); i++) {
			ItemImgDto itemImg = new ItemImgDto();
			itemImg.setFileName(fileList.get(i).getOriginalFilename());
			itemImg.setUuid(UUIDlist.get(i));
			
			/* itemImg객체 정보를imgList에 담기 */
			imgList.add(itemImg);
		}
		
		/* 이미지 리스트를 item에 저장 */
		item.setImageList(imgList);
		
		/* DB등록 */
		boolean chk = adminService.itemRegister(item);
		logger.info("상품등록 성공");
		System.out.println("결과->" + chk);

		model.addAttribute("chk", chk);

		return "/item/itemRegister";

	}

	// 사진 업로드 UUID
	public String uploadFile(String originalFilename, byte[] fileData, String uploadPath) throws Exception {

		UUID uid = UUID.randomUUID();
		// requestPath = requestPath + "/resources/image";
		System.out.println("uploadPath -> " + uploadPath);
		// directory 생성
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdir();
			System.out.println("업로드용 폴더 생성함 : " + uploadPath);
		}
		System.out.println("originalFilename -> " + originalFilename);
		String savedName = "";
		savedName = uid.toString() + "_" + originalFilename; // uuid+원래파일명 = 유일한 파일명
		File target = null;
		target = new File(uploadPath, savedName);
		logger.info("savedName -> " + savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}


////	// 상품등록1
////	@GetMapping("/itemRegister")
////	public String itemRegister(ItemDto item, Model model) {
////		logger.info("상품등록 페이지 진입");
////		System.out.println(item.toString());
////		System.out.println("ItemDto의 이미지 리스트 담겼나?"+item.getImageList());
////		boolean chk = adminService.itemRegister(item);
////		logger.info("상품등록 성공");
////		System.out.println("결과->" + chk);
////
////		model.addAttribute("chk", chk);
////
////		return "/item/itemRegister";
////	}
//

//	
//	private List<String> fileProcess(MultipartHttpServletRequest multipartRequest) throws Exception{
//		List<String> fileList = new ArrayList<String>();
//		Iterator<String> fileNames = multipartRequest.getFileNames();
//		while(fileNames.hasNext()) {
//			String fileName = fileNames.next();
//			MultipartFile mFile = multipartRequest.getFile(fileName);
//			String originalFileName = mFile.getOriginalFilename();
//			fileList.add(originalFileName);
//			File file = new File(CURR_IMAGE_REPO_PATH + "\\" + fileName);
//			if (mFile.getSize()!=0) {
//				if (! file.exists()) {
//					if (file.getParentFile().mkdirs()) {
//						file.createNewFile();
//					}
//				}
//				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH+"\\"+ originalFileName));
//			}
//		}
//		return fileList;
//	}
//
//	// 상품이미지 등록
//	@SuppressWarnings("deprecation")
//	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public ResponseEntity<List<ItemImgDto>> uploadAjaxAction(MultipartFile[] uploadFile) {
//		// MultiparFile: 뷰(View)에서 전송한 multipart 타입의 파일을 다룰 수 있도록 해주는
//		// 인터페이스.MultipartFile[]는 여러개 받을 때 활용
//		logger.info("uploadAjaxAction 시작");
//
//		/* 이미지 파일 유효성 검사 체크-뷰로부터 받은 파일 타입 검사 */
//		for (MultipartFile multipartFile : uploadFile) {
//			File checkfile = new File(multipartFile.getOriginalFilename());
//			String type = null;
//			try {
//				type = Files.probeContentType(checkfile.toPath());
//				logger.info("MIME TYPE->" + type);
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			if (!type.startsWith("image")) {// MIME TYPE이 image 인 경우 첫 단어가 image임.
//				List<ItemImgDto> imgList = null; // image타입이 아닌경우 null로
//				return new ResponseEntity<>(imgList, HttpStatus.BAD_REQUEST);
//			}
//		}
//
//		logger.info("뷰로 부터 전달 받은 파일 정보");
//		for (MultipartFile multipartFile : uploadFile) {
//			logger.info("-----------------------------------------------");
//			logger.info("파일 이름 : " + multipartFile.getOriginalFilename());
//			logger.info("파일 타입 : " + multipartFile.getContentType());
//			logger.info("파일 크기 : " + multipartFile.getSize());
//		}
//
//		/* 날짜별 폴더 경로 생성 */
////		업로드 하는 날짜에 맞게 폴더가 생성되고, 생성된 폴더에 업로드 파일을 저장되도록 할 것
//		String uploadFolder = "C:\\upload";
//		//// 날짜 데이터를 지정된 문자열 형식으로 변환하거나 날짜 문자열 데이터를 날짜 데이터로 변환할 수 있게 해주는 클래스
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		Date date = new Date();
//		String str = sdf.format(date);// 날짜를 문자열로 변환.
//		String datePath = str.replace("-", File.separator);// -을 기준으로 나눠 하위폴더 생성
//		File uploadPath = new File(uploadFolder, datePath);
//		if (uploadPath.exists() == false) { // 존재하지 않을 경우에만 생성
//			uploadPath.mkdirs();// 디렉토리 여러개 만들기
//		}
//
//		/* 이미지파일 정보 담는 객체 리스트 */
//		List<ItemImgDto> imgList = new ArrayList<ItemImgDto>();
//		logger.info("뷰로부터 전달받은 값 imgList에 넣기 시작");
//		for (MultipartFile multipartFile : uploadFile) {
//			/* 이미지 파일 정보 객체 */
//			ItemImgDto itemImage = new ItemImgDto();
//
//			/* 파일 이름 */
//			String uploadFileName = multipartFile.getOriginalFilename();
//			itemImage.setFileName(uploadFileName);// 객체에 정보 담기
//			itemImage.setUploadPath(datePath);// 객체에 정보 담기
//			
//			/* 각 파일이 저장될 때 고유한 이름을 가지도록 UUID 사용 */
//			/* uuid 적용 파일 이름 */
//			String uuid = UUID.randomUUID().toString(); // UUID.randomUUID()를 통해 생성된 '식별자'는 UUID 타입의 데이터 이기 때문에
//														// toString()를 사용해 String으로 변환
//			itemImage.setUuid(uuid);// 객체에 정보 담기
//			uploadFileName = uuid + "_" + uploadFileName;// 고유일련번호_사용자가 정한 파일 이름
//
//			/* 파일 위치, 파일 이름을 합친 File 객체 */
//			File saveFile = new File(uploadPath, uploadFileName);
//
//			/* 파일 저장 */
//			try {
//				multipartFile.transferTo(saveFile);
//
////				/* 썸네일 만들기 방법1 */
////					// Java 에서 자체적으로 제공하는 ImageIO를 이용하거나 간단히 썸네일 이미지를 만들 수 있도록 도와주는 Scalar,
////					// Thumbnailator 등을 이용.
////					File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);// 썸네일 파일이름 규칙 : s_uuid_uploadFileName
////					BufferedImage bo_image = ImageIO.read(saveFile);
////					/* 비율 */
////					double ratio = 3;
////					/*넓이 높이*/
////					int width = (int) (bo_image.getWidth() / ratio);
////					int height = (int) (bo_image.getHeight() / ratio);	
////					
////					BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);// 넓이,높이,생성될 이미지 타입
////	
////					// 썸네일 BufferedImage 객체(bt_image)에서 createGraphics() 메서드를 호출을 통해 Graphic2D 객체를
////					// 생성 해준 후 Graphic2D 타입의 참조 변수에 대입.
////					Graphics2D graphic = bt_image.createGraphics();
////					graphic.drawImage(bo_image, 0, 0,width,height, null);// (그리고자하는 이미지,0,0,넓이,높이, ImageObserver 객체(일반적으로
////																		// null))좌표부터 시작해 이미지를 그림
////	
////					// 그려준 bt_image를 파일로 만들기
////					ImageIO.write(bt_image, "jpg", thumbnailFile);// (파일로 저장할 이미지, 이미지 형식,저장될 객체)
////				/* 썸네일 만들기1 끝 */
////				
//
//				/* 썸네일 만들기 방법2-->pom.xml에 thumbnailator추가하는 방법 */
//				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
//
//				BufferedImage bo_image = ImageIO.read(saveFile);
//
//				// 비율
//				double ratio = 3;
//				// 넓이 높이
//				int width = (int) (bo_image.getWidth() / ratio);
//				int height = (int) (bo_image.getHeight() / ratio);
//
//				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
//				/* 썸네일 만들기 방법2 끝 */
//
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//				imgList.add(itemImage);
//				
//				System.out.println("이미지 리스트에 담았나요?");
//				for (int i = 0; i < imgList.size(); i++) {
//					System.out.println(i+"번째 : " + imgList.get(i).getFileName());
//					System.out.println(i+"번째 : " + imgList.get(i).getUploadPath());
//					System.out.println(i+"번째 : " + imgList.get(i).getUuid());
//					System.out.println("------------------");
//				}
//				System.out.println("이미지 이미지 리스트에 담기 끝.");
//		}
//		// @ResponseEntity는 반환값에 상태 코드와 응답 메시지를 주고 싶을 때 사용한다.
//		ResponseEntity<List<ItemImgDto>> result = new ResponseEntity<List<ItemImgDto>>(imgList, HttpStatus.OK);
//		return result;
//	}
//
//	/* 업로드 한 파일 삭제 */
//	@PostMapping("/deleteUploadFile")
//	public ResponseEntity<String> deleteUploadFile(String fileName) {
//		logger.info("업로드 한 파일 삭제 진입, 파일명: " + fileName);
//
//		File file = null;
//
//		try {
//
//			/* 썸네일 삭제 */
//			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
//			// encode해준거 다시 decode
//			file.delete();
//
//			/* 원본 파일 삭제 */
//			String originFileName = file.getAbsolutePath().replace("s_", "");
//
//			logger.info("originFileName : " + originFileName);
//
//			file = new File(originFileName);
//
//			file.delete();
//
//		} catch (Exception e) {
//
//			e.printStackTrace();
//
//			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
//
//		}
//		return new ResponseEntity<String>("success", HttpStatus.OK);
//
//	}
}
