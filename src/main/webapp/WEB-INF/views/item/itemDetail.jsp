<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>제품 상세페이지</title>

<!-- Core theme CSS (includes Bootstrap)-->
<%@ include file="../gnb_top.jsp"%>
<%@ include file="../gnb_menu.jsp"%>
<link href="/../resources/css/itemDetail.css" rel="stylesheet" />
</head>
<body>

	<!-- Product section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					<img class="card-img-top mb-5 mb-md-0"
						src="http://localhost:8183/shoppingImgs/${item.imageList[0].uuid}"
						alt="itemDetailImg" />
				</div>
				<div class="col-md-6">
					<div class="small mb-1">상품번호: ${item.itemNo}</div>
					<h1 class="display-5 fw-bolder">${item.itemName}</h1>
					<div class="fs-5 mb-5">
						<span class="text-decoration-line-through">${item.itemPrice}</span>
						<c:if test="${item.itemDiscount != 0 }">
							<span>할인율:${item.itemDiscount }</span>
						</c:if>


					</div>
					<!-- 상품설명 -->
					<p class="lead">${item.itemContents }</p>
					<!-- <div class="d-flex">
                            수량:<input class="form-control text-center me-3" id="inputQuantity" type="number" value="" style="max-width: 3rem" />
                            <button class="btn btn-outline-dark flex-shrink-0" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                구매하기
                            </button>
                        </div> -->

					<div class="fs-5 mb-5">

						<div class="jss811">

							<div class="jss812">
								<div>
									<div class="jss813">수량</div>
									<div class="jss821">
										<!-- 								<dd class="alarm no-stock"
									style="background-color: #f4f4f5; display: none; font-size: 14px; font-weight: bold; color: #c34; font-family: 'Noto Sans KR', 'dotum', sans-serif; letter-spacing: -.58px; text-align: justify; line-height: 25px;">일시품절
									- 재고없음</dd>
 -->
										<div class="alarm yes-stock"
											style="background-color: #f4f4f5;">
											<input type="number" name="itemCount" id="itemCount"
												value="0" maxlength="3" minlength="1" min="1"
												max="${item.itemAmount }" autocomplete="off" required>
											<span class=""></span>


											<c:if test="${item.itemAmount==0}">
												<span id="pass_quantity"
													style="margin-left: -1px; text-align: left; display: block; margin-top: 8px; font-weight: bold; color: red; font-family: 'Noto Sans KR', 'dotum', sans-serif; letter-spacing: -.58px; text-align: center;">
													남은재고가 없습니다. </span>
											</c:if>
											<c:if test="${item.itemStatus==0}">
												<span id="pass_quantity"
													style="margin-left: -1px; text-align: left; display: block; margin-top: 8px; font-weight: bold; color: red; font-family: 'Noto Sans KR', 'dotum', sans-serif; letter-spacing: -.58px; text-align: center;">
													삭제된 상품입니다. </span>
											</c:if>
											<c:if test="${item.itemAmount>0}">
												<span id="pass_quantity"
													style="margin-left: -1px; text-align: left; display: block; margin-top: 8px; font-weight: bold; color: #4f9900; font-family: 'Noto Sans KR', 'dotum', sans-serif; letter-spacing: -.58px; text-align: center;">
													(재고 ${item.itemAmount}개 남음) </span>
											</c:if>

											<div class="productWrapper" id="productWrapper"
												style="position: absolute;">
												<div class="layerPop alertMessage" style="display: none;">
													<div class="layerPopWrapper"
														style="top: -20px; left: -27px;">
														<p>
															최대 구매수량은 <span class="important">47</span>개입니다.
														</p>
													</div>
												</div>
											</div>
										</div>
										<span id="itemCount_input_check"></span>
									</div>
								</div>
							</div>
							<div>
								<div></div>
								<div class="jss816" style="margin-top: 10px;">총 상품금액</div>
								<div class="817">
									<strong id="cart_total_price_pc"><span
										class="total_span"></span></strong>원
								</div>
								<div class="jss816" style="font-size: small;">
									적립 포인트 <span class="point_span"></span>p
								</div>
							</div>
						</div>
					</div>
					<div style="padding: 0px 0 0px 0;"></div>
					<div class="fs-5 mb-5">
						<c:if test="${item.itemAmount > 0 && item.itemStatus !=0}">
							<button type="button" id="cart" class="btn btn-primary btn-lg"
								onclick="itemCount_input_check()">
								<i class="bi-cart-fill me-1"></i>장바구니 담기
							</button>
							<button type="button" class="btn btn-outline-danger btn-lg">바로구매</button>
						</c:if>
						<!-- 재고가 없거나 삭제된 상품일경우 버튼 비활성화 -->
						<c:if test="${item.itemAmount == 0 || item.itemStatus == 0}">
							<button type="button" id="cart" class="btn btn-primary btn-lg"
								disabled>
								<i class="bi-cart-fill me-1"></i>장바구니 담기
							</button>
							<button type="button" class="btn btn-outline-danger btn-lg"
								disabled>바로구매</button>
						</c:if>


					</div>



				</div>
			</div>
		</div>
	</section>
	<!-- Related items section-->
	<section class="py-5 bg-light">
		<div class="container px-4 px-lg-5 mt-5">
			<h2 class="fw-bolder mb-4">Related products</h2>
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Product image-->
						<img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Fancy Product</h5>
								<!-- Product price-->
								$40.00 - $80.00
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto" href="#">View
									options</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Special Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								<span class="text-muted text-decoration-line-through">$20.00</span>
								$18.00
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Sale Item</h5>
								<!-- Product price-->
								<span class="text-muted text-decoration-line-through">$50.00</span>
								$25.00
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Product image-->
						<img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Popular Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								$40.00
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<%@ include file="../footer.jsp"%>

	<script type="text/javascript">
		// 서버로 전송할 데이터
		const form = {
			memberId : '${member.memberId}',
			itemNo : '${item.itemNo}',
			itemCount : ''
		}
		//장바구니 버튼 클릭
		$("#cart").on(
				"click",
				function(e) {
					form.itemCount = $("#itemCount").val();

					if ($("#itemCount").val() == ""
							|| $("#itemCount").val() == 0) {//수량이 0이거나 null이면,
						$('#itemCount_input_check').html("수량을 선택하세요").css(
								'color', 'red');
						form.itemCount.focus();
						return false;
					} else {
						$('#itemCount_input_check').html("")
								.css('color', 'red');
						//아작스로 값들 넘겨주기

						$.ajax({
							url : '/cart/insertCart',
							type : 'POST',
							data : form,
							success : function(result) {
								if (result == '0') {
									alert("장바구니에 추가를 하지 못하였습니다.");
								} else if (result == '1') {
									alert("장바구니에 추가되었습니다.");
								} else if (result == '2') {
									alert("장바구니에 이미 추가되어져 있습니다.");
								} else if (result == '3') {
									alert("로그인이 필요합니다.");
								}
							}
						})
					}
				});
		//페이지 처음 진입 시 1개 가격 총 상품금액,적립 포인트
		$(document)
				.ready(
						function() {
							/* 수량*최종판매가, 적립 포인트 계산 */
							let discountPrice = "${item.itemPrice - (item.itemPrice*(item.itemDiscount/100))}"
							let point = discountPrice * 0.05;
							point = Math.floor(point);
							discountPrice = Math.floor(discountPrice);
							$(".point_span").text(point);
							$(".total_span").text(discountPrice);
						});
	</script>
</body>
</html>
