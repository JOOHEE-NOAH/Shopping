<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
#result_card img {
	max-width: 100%;
	height: auto;
	display: block;
	padding: 5px;
	margin-top: 10px;
	margin: auto;
}

#result_card {
	position: relative;
}

.imgDeleteBtn {
	position: absolute;
	top: 0;
	right: 5%;
	background-color: #ef7d7d;
	color: wheat;
	font-weight: 900;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	line-height: 26px;
	text-align: center;
	border: none;
	display: block;
	cursor: pointer;
}
</style>
</head>
<body>
	<form action="/admin/itemRegister">
		<div>
			<label for="itemName">상품명</label> <input type="text"
				class="form-control" id="itemName" name="itemName"
				placeholder="상품명을 입력해주세요" value="" required>
		</div>
		<div>
			<label for="itemCode">카테고리</label> <select id="itemCode"
				name="itemCode" required>
				<option value="" selected disabled hidden>카테고리를 선택해주세요</option>
				<c:forEach var="itemCodeList" items="${itemCodeList }">
					<option value="${itemCodeList.itemCode }">${itemCodeList.itemCodeName }</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label for="itemAmount">재고</label> <input type="number" min="0"
				class="form-control" id="itemAmount" name="itemAmount"
				placeholder="재고를 입력해주세요" value="" required>
		</div>
		<div>
			<label for="itemCost">원가</label> <input type="text"
				class="form-control" id="itemCost" name="itemCost"
				placeholder="원가를 입력해주세요"
				oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)/g, '$1');"
				required>
		</div>
		<div>
			<label for="itemPrice">판매가</label> <input type="text"
				class="form-control" id="itemPrice" name="itemPrice"
				placeholder="판매가를 입력해주세요" value=""
				oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)/g, '$1');"
				required> <span class="priceChk"></span>
		</div>
		<div>
			<label for="itemDiscount">할인율</label> <input type="number" min="0"
				max="100" class="form-control" id="itemDiscount" name="itemDiscount"
				placeholder="할인율을 입력해주세요" value="0" required> <span
				class="discountChk"></span> <span class="discountPrice"></span>
		</div>
		<div>
			<label for="discountPrice">할인 판매가</label> <span id="discountPrice"
				class="discountPrice"></span>
		</div>
		<div>
			<label for="itemContents">상품설명</label> <input type="text"
				class="form-control" id="itemContents" name="itemContents"
				placeholder="상품설명을 입력해주세요" value="" required>
		</div>

		<div class="form_section">
			<div class="form_section_title">
				<label>상품 이미지</label>
			</div>
			<div class="form_section_content">
				<input type="file" multiple id="fileItem" name='uploadFile' required
					style="height: 30px;">
				<div id="uploadResult">
					<!-- 					<div id="result_card">
						<div class="imgDeleteBtn">x</div>
						<img src="/display?fileName=test.png">
					</div> -->

				</div>
			</div>
		</div>


		<button type="submit">상품등록</button>
		<button type="button" onclick="history.go(-1)">취소</button>
	</form>
	<script type="text/javascript">
		/* 판매가 유효성 검사 */
		$(document).ready(
				function() {
					$('#itemPrice').blur(
							function() {
								let itemCost = $('#itemCost').val();
								let itemPrice = $('#itemPrice').val();
								if (itemCost > itemPrice) {
									$('.priceChk').html("손해가 발생하는 판매가입니다.")
											.css('color', 'red');
								} else if (itemCost == itemPrice) {
									$('.priceChk').html("판매가와 원가가 동일합니다.").css(
											'color', 'orange');
								} else if (itemCost < itemPrice) {
									$('.priceChk').html("").css('color',
											'green');
								}
							});
				})
		/* 할인율 유효성 검사 */
		$(document).ready(
				function() {
					$('#itemDiscount').blur(
							function() {
								let itemCost = $('#itemCost').val();
								let itemPrice = $('#itemPrice').val();
								let itemDiscount = $('#itemDiscount').val();
								let discountPrice = itemPrice
										* (1 - itemDiscount / 100);
								if(itemDiscount==""){
									$('#itemDiscount').val("0");
								}
								if (itemCost > discountPrice) {
									$('.discountChk').html("손해가 발생하는 할인율입니다.")
											.css('color', 'red');
									$('.discountPrice').html(discountPrice);
								} else if (itemCost == discountPrice) {
									$('.discountChk').html("할인가와 원가가 동일합니다.")
											.css('color', 'orange');
									$('.discountPrice').html(discountPrice);
								} else if (itemCost < discountPrice) {
									$('.discountChk').html("")
									$('.discountPrice').html(discountPrice);
								}

							});
				})

		/* 이미지 업로드 */
		$("input[type='file']").on("change", function(e) {
			
			/* 이미지 존재시 삭제 */
			if($(".imgDeleteBtn").length > 0){
				deleteUploadFile();
			}
			
			let formData = new FormData();
			/* FormData는 쉽게 말해 가상의 <form> 태그. 흔히 뷰(view)에 서버로 데이터를 전송하기 위해서 <form> 태그를 사용.
				화면의 이동 없이 첨부파일을 서버로 전송을 해야할 때는 <form> 태그와 같은 역할을 해주는 FormData객체를 생성하여 첨부파일을 FormData에 저장을 하고
				FormData 자체를 서버로 전송해야함 */
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			let fileObj = fileList[0];

/* 			console.log("fileList : " + fileList);
			console.log("fileObj : " + fileObj);
			console.log("fileName : " + fileObj.name);
			console.log("fileSize : " + fileObj.size);
			console.log("fileType(MimeType) : " + fileObj.type); */

			if (!fileCheck(fileObj.name, fileObj.size)) {
				return false;
			}
			/* FormData 객체에 데이터를 추가하는 방법은 FormData.append(key, value) 메서드를 사용 
			      파라미터 key의 경우 추가해줄 데이터의 변수를 작성한다고 생각하면됨. 
			   <input>의 name과 Controller의 url 매핑 메서드의 매개변수 이름과 동일하게 해 주었듯이,
			   key와 추후 추가할 url 매핑 메서드의 매개변수명이 동일해야 한다.*/
			//formData.append("uploadFile",fileObj); //->한개의 파일만 선택 시
			//여러개의 파일 선택 시
			for (let i = 0; i < fileList.length; i++) {
				formData.append("uploadFile", fileList[i]);
			}
			let temp = 0;
			//파일 정보 서버로 전송
			$.ajax({
				url : '/admin/uploadAjaxAction',
				processData : false,
				contentType : false,
				asyce : false;
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					temp = result;
					console.log(result);
					showUploadImg(result)/* 업로드한 사진파일 바로 보여주는 function */
				},
				error : function(result) {
					alert("이미지 파일이 아닙니다.");
					$('#fileItem').val("");
				}
			});

		});

		/* 첨부파일 유효성 검사.(jpg/png만 허용) */
		let regex = new RegExp("(.*?)\.(jpg|png)$");
		let maxSize = 1048576; //1MB
		function fileCheck(fileName, fileSize) {

			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				$('#fileItem').val("");
				return false;
			}

			if (!regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				$('#fileItem').val("");
				return false;
			}

			return true;

		}

		/* 업로드한 사진파일 바로 보여주는 function */
		function showUploadImg(uploadResultArray){/* 서버에서 뷰로 반환 시 List->배열 형태로 전달 받음 */
			/* 전달 받은 데이터 확인 */
			if(!uploadResultArray || uploadResultArray.length == 0){return}
			
			let uploadResult = $("#uploadResult");
			
			//업로드한 사진 중 하나만 대표 미리보기
//			let obj = uploadResultArray[0];
			
			/* 추가될 태그 코드 저장할 변수 선언 및 초기화 */
//			let str=""; 
			
			/* 썸네일로 저장된 파일의 경로 */
//			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						  	/* UTF-8로 인코딩 */	
			
			/* 선택한 사진 파일 나오게 하는 태그 코드 문자열들 저장 */
//				str += "<div id='result_card'>";
//				str += "<img src='/display?fileName=" + fileCallPath +"'>";
//				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
//				str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
//				str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
//				str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";	
//				str += "</div>";
				
//			uploadResult.append(str); /* id=uploadResult 태그에 위의 str값 추가 */				  	
						  	
			//업로드한 모든 사진 미리보기
			for (let i = 0; i < uploadResultArray.length; i++) {
				let obj = uploadResultArray[i];
				
				/* 추가될 태그 코드 저장할 변수 선언 및 초기화 */
				let str=""; 
				
				/* 썸네일로 저장된 파일의 경로 */
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
							  	/* UTF-8로 인코딩 */				
			
				/* 선택한 사진 파일 나오게 하는 태그 코드 문자열들 저장 */
				str += "<div id='result_card'>";
				str += "<img src='/display?fileName=" + fileCallPath +"'>";
				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
				str += "<input type='hidden' name='imageList["+i+"].fileName' value='"+ obj.fileName +"'>";
				str += "<input type='hidden' name='imageList["+i+"].uuid' value='"+ obj.uuid +"'>";
				str += "<input type='hidden' name='imageList["+i+"].uploadPath' value='"+ obj.uploadPath +"'>";	
				str += "</div>";
				
				uploadResult.append(str); /* id=uploadResult 태그에 위의 str값 추가 */	
			}
		}
		
		/* 파일 삭제 버튼 동작 */
		$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
			
			deleteUploadFile(); //삭제 메서드 동작
			
		});
		
		/* 파일 삭제 메서드 */
		function deleteUploadFile(){
			
			let deleteFile = $(".imgDeleteBtn").data("file");
			
			let deleteDiv = $("#result_card");
			
			$.ajax({
				url: '/admin/deleteUploadFile',
				data : {fileName : deleteFile},
				dataType : 'text',
				type : 'POST',
				success : function(result){
					console.log(result);
					
					deleteDiv.remove();
					$("input[type='file']").val("");
					
				},
				error : function(result){
					console.log(result);
					
					alert("파일을 삭제하지 못하였습니다.")
				}
			});
		}
		
		
	</script>
</body>
</html>
