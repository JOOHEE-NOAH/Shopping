<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>메타독 메인페이지</title>
<%@ include file="gnb_top.jsp"%>
<%@ include file="gnb_menu.jsp"%>
<%@ include file="header.jsp"%>
</head>
<body>

		<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">

			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">


				<c:forEach var="itemList" items="${itemList }">


					<div class="col mb-5">
						<div class="card h-100">
							<!-- Product image-->
							<img class="card-img-top"
							src="http://localhost:8183/shoppingImgs/${itemList.imageList[0].uuid}" alt="itemImg" />
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder">${itemList.itemName }</h5>
									<!-- Product price-->
									<span class="text-muted text-decoration-line-through">${itemList.itemPrice }</span>
									<c:if test="${itemList.itemDiscount != 0 }">
									할인율 ${itemList.itemDiscount }
									</c:if>
									<c:if test="${itemList.itemAmount < 5 }">
									품절임박!!
									</c:if>
									
									
								</div>
							</div>
							<!-- Product actions-->
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
									<a class="btn btn-outline-dark mt-auto" href="/itemDetail?itemNo=${itemList.itemNo }">제품상세</a>
								</div>
							</div>
						</div>
					</div>
					
					
				</c:forEach>

			</div>
		</div>
		         <!-- pagination -->
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${pg.startPage > pg.pageBlock }">
							<li class="page-item"><a class="page-link" href="market?currentPage=${pg.startPage-pg.pageBlock}"
								aria-label="Previous" id="page_btn"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
							<li class="page-item"><a class="page-link" href="market?currentPage=${i}"
								id="page_btn">${i}</a></li>
						</c:forEach>
						<c:if test="${pg.endPage < pg.totalPage }">
							<li class="page-item"><a class="page-link" href="market?currentPage=${pg.startPage+pg.pageBlock}"
								aria-label="Next" id="page_btn"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
					</ul>
				</nav>
		<!-- pagination end-->
	</section>
	<!-- Footer-->
	<%@ include file="footer.jsp"%>

</body>
</html>
