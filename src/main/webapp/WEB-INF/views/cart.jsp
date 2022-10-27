<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>제품 상세페이지</title>
<%@ include file="gnb_top.jsp"%>
<%@ include file="gnb_menu.jsp"%>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap"
	rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet"
	href="<c:url value="/resources/css/bootstrap.min.css"/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/font-awesome.min.css"/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/elegant-icons.css"/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/nice-select.css"/>" type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/jquery-ui.min.css"/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/owl.carousel.min.css"/>"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/slicknav.min.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>"
	type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/cart.css"/>"
	type="text/css" />
<style type="text/css">
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>
<body>
	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="http://localhost:8183/shoppingImgs/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>Shopping Cart</h2>
						<div class="breadcrumb__option">
							<a href="./index.html">Home</a> <span>Shopping Cart</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->
	<!-- Shoping Cart Section Begin -->
	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<table>
							<thead>
								<tr>
									<th class="shoping__product all_check_input_div">
										<div class="all_check_input_div">
											<input type="checkbox" class="all_check_input"
												checked="checked"><span class="all_chcek_span"></span>
										</div>
									</th>
									<th>제품명</th>
									<th>가격</th>
									<th>수량</th>
									<th>총금액</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cartList}" var="cartList">
									<tr>
										<td class="cart_info_td">
											<!-- 자바스크립트에서 계산할 정보 가져오기 --> <input type="checkbox"
											class="individual_cart_checkbox" checked="checked"> <input
											type="hidden" class="itemPrice_input"
											value="${cartList.itemPrice }"> <input type="hidden"
											class="discountPrice_input"
											value="${cartList.discountPrice }"> <input
											type="hidden" class="itemCount_input"
											value="${cartList.itemCount }"> <input type="hidden"
											class="totalPrice_input"
											value="${cartList.discountPrice * cartList.itemCount }">
											<input type="hidden" class="point_input"
											value="${cartList.point }"> <input type="hidden"
											class="totalPoint_input" value="${cartList.totalPoint }">

										</td>
										<td class="shoping__cart__item"><img
											style="width: 100px; height: 100px;"
											src="<c:url value="http://localhost:8183/shoppingImgs/${cartList.imageList[0].uuid}"/>"
											alt="">
											<h5>${ cartList.itemName}</h5></td>
										<td class="shoping__cart__price"><fmt:formatNumber
												value="${ cartList.discountPrice}" pattern="#,### 원" /></td>
										<td class="shoping__cart__quantity">
											<form action="/cart/changeItemCount" method="post"
												class="quantity_update_form">
												<input type="hidden" name="cartNo" class="cartNo"
													value="${cartList.cartNo }"> <input type="hidden"
													name="memberId" value="${member.memberId}">

												<div class="quantity">
													<div class="itemCount">
														 <input
															class="itemCountNum" type="number" name="itemCount"
															min="1" max="${cartList.itemAmount }" autocomplete="on"
															value="${ cartList.itemCount}">
													</div>
													<button type="submit" class="quantity_modify_btn">변경</button>
												</div>
											</form>
										</td>
										<td class="shoping__cart__total"><fmt:formatNumber
												value="${ cartList.discountPrice*cartList.itemCount}"
												pattern="#,### 원" /></td>
										<td class="shoping__cart__item__close"><a
											class="delete_btn"
											href="javascript:deleteItem(${cartList.cartNo })">X</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__btns">
						<a href="#" class="primary-btn cart-btn">CONTINUE SHOPPING</a> <a
							href="#" class="primary-btn cart-btn cart-btn-right"><span
							class="icon_loading"></span> Upadate Cart</a>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__continue">
						<div class="shoping__discount">
							<h5>Discount Codes</h5>
							<form action="#">
								<input type="text" placeholder="Enter your coupon code">
								<button type="submit" class="site-btn">APPLY COUPON</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__checkout">
						<h5>Cart Total</h5>
						<ul>
							<li>총 상품가격 <span>원</span><span class="totalPrice_span"></span></li>
							<li>배송비 <span>원</span><span class="delivery_price"></span></li>
							<li>총 주문 상품수 <span>개</span><span class="totalCount_span"></span><span>종</span><span
								class="totalKind_span"></span>
							</li>
							<li>적립 포인트 <span>p</span><span class="totalPoint_span"></span></li>
							<li>총 결제금액 <span>원</span><span class="finalTotalPrice_span"></span></li>
						</ul>
						<a href="#" class="primary-btn">주문하기</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shoping Cart Section End -->

	<!-- 수량 조정 form -->


	<!-- Footer-->
	<%@ include file="footer.jsp"%>
	<script type="text/javascript">
	$(document).ready(function(){
		<!-- 페이지 시작과 동시에 종합정보 메소드 동작 -->
		totalInfo();
	});
	
	/* 체크박스 전체 선택 */
	$(".all_check_input").on("click", function(){
		/* 체크박스 체크/해제 */
		if($(".all_check_input").prop("checked")){
			$(".individual_cart_checkbox").attr("checked", true);
		} else{
			$(".individual_cart_checkbox").attr("checked", false);
		}
		
		/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
		totalInfo($(".cart_info_td"));	
		
	});
	
	/* 체크여부에따른 종합 정보 변화 */
	$(".individual_cart_checkbox").on("change", function(){
		/* 체크 상태에 따라 총 주문 정보 변화*/
		totalInfo($(".cart_info_td"));
	});
	
		/* 총 주문정보 */
		function totalInfo() {
			$(document)
					.ready(
							function() {
								let totalPrice = 0; // 총 가격
								let totalCount = 0; // 총 갯수
								let totalKind = 0; // 총 종류
								let totalPoint = 0; // 총 포인트
								let deliveryPrice = 0; // 배송비
								let finalTotalPrice = 0; // 최종 가격(총 가격 + 배송비)

								$(".cart_info_td").each(
										function(index, element) {//index: 순회하는 객체의 인덱스(like 배열),element: 순회 대상 각 객체 

											if($(element).find(".individual_cart_checkbox").is(":checked") === true){ //체크되어있는 경우에만 종합정보에 포함되어 계산
												// 총 가격
											totalPrice += parseInt($(element)
													.find(".totalPrice_input")
													.val());
											// 총 갯수
											totalCount += parseInt($(element)
													.find(".itemCount_input")
													.val());
											// 총 종류
											totalKind += 1;
											// 총 포인트
											totalPoint += parseInt($(element)
													.find(".totalPoint_input")
													.val());
												
											}
											

										});

								/* 배송비*/
								if (totalPrice >= 25000) {
									deliveryPrice = 0;
								} else if (totalPrice == 0) {
									deliveryPrice = 0;
								} else {
									deliveryPrice = 2500;
								}

								/* 최종 가격 */
								finalTotalPrice = totalPrice + deliveryPrice;

								/* 계산 값 삽입 */
								// 총 가격
								$(".totalPrice_span").text(
										totalPrice.toLocaleString());
								// 총 갯수
								$(".totalCount_span").text(totalCount);
								// 총 종류
								$(".totalKind_span").text(totalKind);
								// 총 마일리지
								$(".totalPoint_span").text(
										totalPoint.toLocaleString());
								// 배송비
								$(".delivery_price").text(
										deliveryPrice.toLocaleString());
								// 최종 가격(총 가격 + 배송비)
								$(".finalTotalPrice_span").text(
										finalTotalPrice.toLocaleString());

							});

		}
		
	    // 댓글삭제(AJax 처리)
	    function deleteItem(cartNo) {
	        var query = {cartNo : cartNo};
	        var ans = confirm("선택하신 댓글을 삭제하시겠습니까?");
	        if(!ans) return false;
	        
	        $.ajax({
	            url  : "/cart/deleteCart",
	            type : "post",
	            data : query,
	            success : function(data) {
	                    //alert("댓글이 삭제 되었습니다.");
	                  location.reload();
	            },
	           	error : function(data) {
	                alert("댓글이 삭제되지 않았습니다.");
	            }
	        });
	    }

	


	</script>

	<!-- Js Plugins -->
	<script src="/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.nice-select.min.js"></script>
	<script src="/resources/js/jquery-ui.min.js"></script>
	<script src="/resources/js/jquery.slicknav.js"></script>
	<script src="/resources/js/mixitup.min.js"></script>
	<script src="/resources/js/owl.carousel.min.js"></script>
	<script src="/resources/js/main.js"></script>


</body>
</html>
