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

<title>메타독</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="photos/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="resources/css/styles.css" rel="stylesheet" />
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<!-- Popper Js -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<body>
	<!-- Navigation-->
	<!-- header1 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="#!">Meta Dog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"></li>
					<li class="nav-item"><a class="nav-link" href="#!">About</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#!">All Products</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">Popular Items</a></li>
							<li><a class="dropdown-item" href="#!">New Arrivals</a></li>
						</ul></li>
					<input type="text" id="keyword" class="head_input"
						value="${keyword }" placeholder="동네 이름, 물품명 등을 검색해보세요 !" />
					<button class="btn btn-outline-secondary" type="button" value="확인1"
						id="button-addon2">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>

				</ul>
				<!-- <form class="d-flex"> -->


				<!-- 로그인 전 -->
				<c:if test="${member == null && admin == null}">

					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#loginModal" onclick="openLoginModal()">로그인/회원가입</button>

					<!-- Modal -->
					<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
						aria-labelledby="loginLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content"></div>
						</div>
					</div>
				</c:if>

				<!-- 로그인 후: 일반사용자 -->
				<c:if test="${member!=null}">
					<span>${member.memberName }님 반갑습니다.&nbsp</span>

					<button class="btn btn-outline-dark" type="submit">
						<i class="bi-cart-fill me-1"></i> Cart <span
							class="badge bg-dark text-white ms-1 rounded-pill">0</span>
					</button>

					<!-- Example single danger button -->
					<div class="btn-group">
						<button type="button" class="btn btn-danger dropdown-toggle"
							data-bs-toggle="dropdown" aria-expanded="false">마이페이지</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">주문목록</a></li>
							<li><a class="dropdown-item" href="#">찜한상품</a></li>
							<li><a class="dropdown-item" href="#">최근본상품</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">회원정보변경</a></li>
							<li><a class="dropdown-item" href="#">1:1문의</a></li>
							<li><a class="dropdown-item" data-toggle="modal"
								data-target="#logoutModal">로그 아웃</a></li>
						</ul>
					</div>

					<!-- Logout Modal -->
					<div class="modal fade" id="logoutModal" tabindex="-1"
						role="dialog" aria-labelledby="logoutLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">

								<!-- history Modal -->
								<!-- Modal Header -->
								<div class="modal-header">
									<h5 class="modal-title" id="logoutLabel">로그아웃</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>

								<!-- Modal Body -->
								<div class="modal-body">
									<br> <span>정말 로그아웃 하시겠습니까?</span>

								</div>
								<br>
								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-danger" onclick="logout()">확인</button>
									<button type="button" class="btn btn-danger"
										data-dismiss="modal">취소</button>
								</div>


							</div>
						</div>
					</div>
				</c:if>

				<!-- 로그인 후: 관리자 -->
				<c:if test="${admin!=null}">
					<span>${admin.adminName }님 반갑습니다.&nbsp</span>

					<div class="btn-group">
						<button type="button" class="btn btn-danger dropdown-toggle"
							data-bs-toggle="dropdown" aria-expanded="false">관리자페이지</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">주문목록</a></li>
							<li><a class="dropdown-item" href="#">찜한상품</a></li>
							<li><a class="dropdown-item" href="#">최근본상품</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">회원정보변경</a></li>
							<li><a class="dropdown-item" href="#">1:1문의</a></li>
							<li><a class="dropdown-item" data-toggle="modal"
								data-target="#adminLogoutModal">로그 아웃</a></li>
						</ul>
					</div>
					<!-- Logout Modal -->
					<div class="modal fade" id="adminLogoutModal" tabindex="-1"
						role="dialog" aria-labelledby="logoutLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">

								<!-- history Modal -->
								<!-- Modal Header -->
								<div class="modal-header">
									<h5 class="modal-title" id="logoutLabel">로그아웃</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>

								<!-- Modal Body -->
								<div class="modal-body">
									<br> <span>정말 로그아웃 하시겠습니까?</span>

								</div>
								<br>
								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-danger" onclick="adminLogout()">확인</button>
									<button type="button" class="btn btn-danger"
										data-dismiss="modal">취소</button>
								</div>


							</div>
						</div>
					</div>
				</c:if>



				<!-- </form> -->
			</div>
		</div>
	</nav>
	<!-- header1 end -->
	
	
	
	<!-- header2 -->
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">
					소중한 우리 댕댕이를 위한<br>DogDog한 선택!
				</h1>
				<p class="lead fw-normal text-white-50 mb-0">프리미엄 애견 쇼핑몰 메타독</p>
			</div>
		</div>
	</header>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"></li>
					<li class="nav-item"><a class="nav-link" href="#!">전체상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">신상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">베스트</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">사료/간식</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">의류/악세서리</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">목욕/미용</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">장난감</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">용품</a></li>

				</ul>
			</div>
		</div>
	</nav>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script>
		/*로그인 모달창 열기*/
		function openLoginModal() {
			$('.modal-content').load("/member/loginForm");// modal-content div영역 안에 외부jsp 모달로 호출
			/* $('#loginModal').modal(); */
		}
		
		//회원 로그아웃
		function logout() {
			$.ajax({
				url : '/member/logout',
				type : "post",
				success : function(data) {
						alert('로그아웃 되었습니다.');
						document.location.reload();
				}
			});
		}
		
		//관리자 로그아웃
		function adminLogout() {
			$.ajax({
				url : '/admin/adminLogout',
				type : "post",
				success : function(data) {
						alert('로그아웃 되었습니다.');
						document.location.reload();
				}
			});
		}
		
		
	</script>
</body>
</html>
