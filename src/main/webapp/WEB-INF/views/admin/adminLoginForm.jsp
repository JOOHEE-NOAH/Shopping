<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<!-- jQuery 스크립트가 자바스크립트의 스크립트 태그보다 위에 위치 해야함-->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>

<style>
body {
	min-height: 100vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 680px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
</style>


<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">관리자 로그인</h4>
				<div class="was-validated">
					<div class="mb-3">
						<label for="adminId">아이디</label> <input type="text"
							class="form-control" id="adminId" name="adminId"
							placeholder="아이디를 입력하세요" required>
						<div class="valid-feedback">확인</div>
						<div class="invalid-feedback">아이디를 입력해주세요</div>

					</div>
					<div class="mb-3">
						<label for="adminPw">비밀번호</label> <input type="text"
							class="form-control" id="adminPw" name="adminPw"
							placeholder="비밀번호를 입력하세요" required>
						<div class="valid-feedback">확인</div>
						<div class="invalid-feedback">비밀번호를 입력해주세요</div>
						<span class="loginFail"></span>
					</div>

					<div class="mb-4"></div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<button class="btn btn-primary btn-lg btn-block" id="join_button"
								type="button" onclick="login()">로그인</button>
						</div>

						<div class="col-md-6 mb-3">
							<button class="btn btn-primary btn-lg btn-block"
								onclick="goPreForm()">뒤로가기</button>
						</div>
					</div>
				</div>

			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; 2021 YD</p>
		</footer>
	</div>
	<script type="text/javascript">
		//로그인 기능
		function login() {
			var adminId = $('#adminId').val();
			var adminPw = $('#adminPw').val();
			$.ajax({
				url : '/admin/adminLogin',
				type : "post",
				data : {
					"adminId" : adminId,
					"adminPw" : adminPw
				},
				dataType : 'text',
				success : function(data) {
					if (data == "fail") {
						$('.loginFail').html("아이디 또는 패스워드가 틀렸습니다.").css(
								'color', 'red');
					} else if (data == "success") {
						alert('로그인되었습니다.');
						location.href = "/main";
					}
				}
			});
		}
	</script>
</body>

</html>
