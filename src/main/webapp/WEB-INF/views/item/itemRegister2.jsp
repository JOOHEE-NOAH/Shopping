<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록결과</title>
</head>
<body>
<h1>상품이 등록되었습니다.</h1>
<label>업로드 파일</label>
<div class="result-images">
	<c:forEach var="imageFileName" items="${map.fileList }" >
		<img src="${pageContext.request.contextPath }/download?imageFileName=${imageFileName}">
	
	</c:forEach>
</div>
</body>
</html>