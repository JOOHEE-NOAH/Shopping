<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메타독</title>
</head>
<body>
<c:choose>
<c:when test="${(chk == true  )}">
	<script type="text/javascript">
		alert("상품이 등록되었습니다.");
		location.href="/main";
	</script>
</c:when>
<c:otherwise>
	<script type="text/javascript">
		alert("상품등록에 실패했습니다.");
		location.href="/main";
	</script>
</c:otherwise>
</c:choose>
</body>
</html>