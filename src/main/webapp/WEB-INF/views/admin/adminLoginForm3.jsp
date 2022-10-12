<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- jQuery 스크립트가 자바스크립트의 스크립트 태그보다 위에 위치 해야함-->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
					$('.loginFail').html("아이디 또는 패스워드가 틀렸습니다.").css('color',
							'red');
				} else if (data == "success") {
					alert('로그인되었습니다.');
					location.href = "/main";
				}
			}
		});
	}
</script>
</head>
<body>

	<!-- history Modal -->
	<!-- Modal Header -->
	<div class="modal-header">
		<h5 class="modal-title" id="adminLoginModal">관리자 로그인</h5>
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>

	<!-- Modal Body -->
	<div class="modal-body">
		<div class="was-validated">
			<div class="form-group">
				<label for="adminId">아이디 </label> <input type="text"
					class="form-control" id="adminId" placeholder="아이디를 입력하세요"
					name="adminId" required>
				<div class="valid-feedback">확인</div>
				<div class="invalid-feedback">아이디를 입력해주세요</div>
			</div>
			<div class="form-group">
				<label for="adminPw">비밀번호 </label> <input type="password"
					class="form-control" id="adminPw" placeholder="비밀번호를 입력하세요"
					name="adminPw" required>
				<div class="valid-feedback">확인</div>
				<div class="invalid-feedback">비밀번호를 입력해주세요</div>
				<span class="loginFail"></span>
			</div>
			<button type="button" class="btn btn-primary"
				style="margin-left: 50%;" onclick="login()">로그인</button>

		</div>

	</div>

	<!-- Modal footer -->
	<div class="modal-footer">
		<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
	</div>


</body>
</html>
