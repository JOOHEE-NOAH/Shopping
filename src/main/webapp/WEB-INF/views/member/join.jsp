<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 확인</title>
</head>
<body>
<c:choose>
<c:when test="${(chk == true  )}">
	<script type="text/javascript">
		alert("회원가입이 완료되었습니다. 가입 포인트로 2000p 지급되었습니다.");
		location.href="/main";
	</script>
</c:when>
<c:otherwise>
	<script type="text/javascript">
		alert("회원가입에 실패했습니다.");
		location.href="/main";
	</script>
</c:otherwise>
</c:choose>
</body>
</html>