<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
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
/* .idchk{
	color: rgb(253, 201, 0);
	font-size: 0.7rem;
	position: relative;
	bottom: 23px;
}
.pwchk {
	font-size: 0.7rem;
	position: relative;
	bottom: 23px;
}

.pwchk1 {
	font-size: 0.7rem;
	position: relative;
	bottom: 23px;
} */
</style>
<script type="text/javascript">
//아이디 유효성검사
	$(document).ready(function() {
		var RegexId = /^[a-z0-9_-]{3,16}$/;
		$('#memberId').blur(function() {
		if($.trim($("#memberId").val())==""){
			$('.idchk').html("아이디를 입력해주세요").css('color','red');
			$('#memberId').val("");
		}else if(!RegexId.test($.trim($("#memberId").val()))){
				$('.idchk').html(" 영어 또는 숫자 3~16자리").css('color','red');
				$('#memberId').val("");
			}else{
				var memberId = $('#memberId').val();
				 $.ajax(
			   		 {
			 				url:'/member/idCheck',
									type : "get",
									data : {
										"memberId" : memberId
									},
									dataType : 'text',
									success : function(data) {
										if (data == "redundancy") {
											$('.idchk').html("중복된 아이디입니다").css(
													'color', 'red');
											$('#memberId').val("");
										} else if (data == "noredundancy") {
											$('.idchk').html("사용가능한 아이디입니다")
													.css('color', 'green');
											;
										}
									}
								});
							};
						});
			})

	//이름 유효성 검사
	$(document).ready(
			function() {
				$('#memberName').blur(
						function() {
							var pattern_num = /[0-9]/; // 숫자 
							var pattern_eng = /[a-zA-Z]/; // 문자 
							var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
							var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크
							if (pattern_kor.test($('#memberName').val())
									&& !(pattern_eng.test($('#memberName')
											.val()))
									&& !(pattern_spc.test($('#memberName')
											.val()))
									&& !(pattern_num.test($('#memberName')
											.val()))) {
								$('.memberNamechk').html("완료").css(
										'color', 'green');
							} else if($('#memberName').val()==""){
								$('.memberNamechk').html("이름을 입력해주세요").css(
										'color', 'red');
							}else{
								$('.memberNamechk').html("한글로 입력해주세요").css(
										'color', 'red');
								$('#memberName').val("");
							}
						});
			})
	//비밀번호 유효성 검사
	$(document).ready(
			function() {
				$('#memberPw').blur(
						function() {
							var memberPw = $('#memberPw').val();
							var num = memberPw.search(/[0-9]/g);
							var eng = memberPw.search(/[a-z]/ig);
							var spe = memberPw
									.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
							if(!$('#memberPw').val()){
								$('.pwchk1').html("비밀번호를 입력해주세요")
								.css('color', 'red');
							}else if ($('#memberPw').val().length < 8
									|| $('#memberPw').val().length > 16) {
								$('.pwchk1').html("비밀번호는 8 ~ 16자리 사이로 입력해주세요")
										.css('color', 'red');
								$('#memberPw').val("");
							} else {
								if (num < 0 || eng < 0 || spe < 0) {
									$('.pwchk1').html(
											"비밀번호는 문자, 숫자, 특수문자의 조합으로 입력해주세요")
											.css('color', 'red');
									$('#memberPw').val("");
								} else {
									$('.pwchk1').html("사용가능한 비밀번호입니다").css(
											'color', 'green');
								}
							}
							;
						});
			})
	//비밀번호 중복확인
	$(document).ready(function() {
		$('#memberPwCheck').blur(function() {
			if(!$('#memberPwCheck').val()){
				$('.pwchk').html("비밀번호를 한번 더 입력해주세요.").css('color', 'red');
			}else if ($('#memberPwCheck').val() != $('#memberPw').val()) {
				$('.pwchk').html("비밀번호가 일치하지 않습니다").css('color', 'red');
				$('#memberPwCheck').val("");
			} else {
				$('.pwchk').html("비밀번호가 일치합니다").css('color', 'green');
			}
		});
	})
	//이메일유효성검사
	$(document).ready(function() {
		var PatternEmail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
		$('#memberEmail').blur(function() {
			if (!PatternEmail.test($.trim($("#memberEmail").val()))) {
				$('.emailchk').html(" 이메일을 입력해주세요 ex)metaDog@gmail.com").css('color', 'red');
				$('#memberEmail').val("");
			} else {
				$('.emailchk').html(" 이메일이 입력되었습니다.").css('color', 'green');
			}
			;
		});
	})
	
	//주소 찾기 API사용
	function kakaoAddress(){
		new daum.Postcode({
	        oncomplete: function(data) {
	        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    
                    //주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;
                
                } else {
                   addr += ' ';
                }
                
                $("#address1").val(data.zonecode);
                //$("[name=address1]").val(data.zonecode);    // 대체가능
                $("#address2").val(addr);
                //$("[name=address2]").val(addr);            // 대체가능
                //상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동시키기
                $("#address3").attr("readonly",false);
                $("#address3").focus();
	 
	        }
	    }).open();
    
}
	
	//전화번호 유효성검사(아예 null이거나 xxx-xxxx-xxx일경우만 허용)
	$(document)
			.ready(
					function() {
						var patternPhoneNumber = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
						/* var PatternPhone = /^[0-9]{4}+\-[0-9]{4}$/i; //이메일 요휴성검사	 */
						$('#phoneNumber')
								.blur(
										function() {
											if (!$("#phoneNumber").val()) {
												$('#phoneNumber').val("");
											} else if (!patternPhoneNumber
													.test($.trim($(
															"#phoneNumber")
															.val()))) {
												$('.phchk')
														.html(
																" 휴대폰번호는 XXX-XXXX-XXXX 형식으로 입력해주세요.")
														.css('color', 'red');
												$('#phoneNumber').val("");
											} else {
												$('.phchk').html(" 휴대폰번호 입력완료")
														.css('color', 'green');
											}
											;
										});
					})

	//취소클릭 시 로그인 화면으로
	function goPreForm() {
		location.href = "/main";
	} 
</script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>

<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원가입</h4>
				<form method="post" action="/member/join">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="memberId">아이디</label> <input type="text"
								class="form-control" id="memberId" name="memberId"
								maxlength="50" placeholder="아이디를 입력해주세요" required> <span
								class="idchk"></span>
						</div>
						<div class="col-md-6 mb-3">
							<label for="memberName">이름</label> <input type="text"
								class="form-control" id="memberName" name="memberName"
								placeholder="이름을 입력해주세요" value="" required> <span
								class="memberNamechk"></span>

						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="memberPw">비밀번호</label> <input type="text"
								class="form-control" id="memberPw" name="memberPw"
								placeholder="비밀번호를 입력해주세요" value="" required> <span
								class="pwchk1"></span>
						</div>

						<div class="col-md-6 mb-3">
							<label for="memberPwCheck">비밀번호 확인</label> <input type="text"
								class="form-control" id="memberPwCheck"
								placeholder="비밀번호를 다시 한번 입력해주세요" value="" required><span
								class="pwchk"></span>
						</div>

					</div>
					<div class="mb-3">
						<label for="memberEmail">이메일</label> <input type="text"
							class="form-control" id="memberEmail" name="memberEmail"
							placeholder="metadog@example.com" required="required"> <span
							class="emailchk"></span>
					</div>

					<div class="mb-3">
						<label for="phoneNumber">휴대폰 번호</label> <input type="text"
							class="form-control" id="phoneNumber" name="phoneNumber">
						<span class="phchk"></span>
					</div>

					<div class="mb-3">
						<!-- <div class="address_wrap">
							<div class="address_name">주소</div>
							<div class="address_input_1_wrap">
								<div class="address_input_1_box">
									<input class="address_input_1" name="address1">
								</div>
								<div class="address_button">
									<span>주소 찾기</span>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="address_input_2_wrap">
								<div class="address_input_2_box">
									<input class="address_input_2">
								</div>
							</div>
							<div class="address_input_3_wrap">
								<div class="address_input_3_box">
									<input class="address_input_3">
								</div>
							</div>
						</div> -->
						<label for="address1">우편번호
							<span class="text-muted">
								<button type="button" class="btn" id="check_btn" onclick="kakaoAddress()">주소찾기</button>
						</span>
						</label> <input type="text" class="form-control" id="address1"
							name="address1" placeholder="찾기를 눌러 주소를 입력하세요" readonly="readonly">
					</div>

					<div class="mb-3">
						<label for="address2">주소</label>
						<input type="text" class="form-control" id="address2"
							name="address2" readonly="readonly">
					</div>
					<div class="mb-3">
						<label for="address3">상세주소<span class="text-muted">&nbsp;(선택사항)</span></label>
						<input type="text" class="form-control" id="address3"
							name="address3" readonly="readonly">
					</div>
					<div class="mb-4"></div>

					<button class="btn btn-primary btn-lg btn-block" id="join_button"
						type="submit">가입 완료</button>
				</form>
				<br>
				<button class="btn btn-primary btn-lg btn-block" onclick="goPreForm()">뒤로가기</button>

			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; 2021 YD</p>
		</footer>
	</div>

	<script>

/* $(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$("#join_button").click(function(){
		$("#joinForm").attr("action", "/member/join");
		$("#joinForm").submit();
	});
}); */

</script>
</body>

</html>