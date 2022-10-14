<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
	<form method="post" name="fileForm" action="/admin/itemRegister" enctype="multipart/form-data">
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
<!-- 		<input type="button" value="파일추가" onclick="fn_addFile()"/><br>
		<div id="d_file">
		
		
		</div> -->
		<div>
		<input multiple="multiple" type="file" name="file" />
        <input type="text" name="src" />
		</div>
		
		
		
		
<!-- 		<div id="fileDiv">
			<p>
				<input type="file" id="file" name="file_0">
				<a href="#this" class="btn" id="delete" name="delete">삭제</a>
			</p>
		</div> -->
		
		<br/><br/>
		<!-- <a href="#this" class="btn" id="addFile">파일 추가</a> -->
	

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
				
				
/* 		var cnt = 1;
		function fn_addFile() {
			$("#d_file").append("<br><input type='file' name='file"+cnt+"' />");
			cnt++;
		} */
		
		
		//파일추가 버튼 클릭하면 동적으로 파일 업로드 추가.
//		var gfv_count = 1;
//		$(document).ready(function(){
//			$("#write").on("click", function(e){ //작성하기 버튼
//				e.preventDefault();
//				fn_insertBoard();
//			});
//			
//			$("#addFile").on("click", function(e){ //파일 추가 버튼
//				e.preventDefault();
//				fn_addFile();
//			});
//			
//			$("a[name='delete']").on("click", function(e){ //삭제 버튼
//				e.preventDefault();
//				fn_deleteFile($(this));
//			});
//		});
//		
//		function fn_insertBoard(){
//			var comSubmit = new ComSubmit("frm");
//			comSubmit.setUrl("<c:url value='/admin/insertItem' />");
//			comSubmit.submit();
//		}
//		
//		function fn_addFile(){
//			var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
//			$("#fileDiv").append(str);
//			$("a[name='delete']").on("click", function(e){ //삭제 버튼
//				e.preventDefault();
//				fn_deleteFile($(this));
//			});
//		}
//		
//		function fn_deleteFile(obj){
//			obj.parent().remove();
//		}
		
		
	</script>
</body>
</html>
