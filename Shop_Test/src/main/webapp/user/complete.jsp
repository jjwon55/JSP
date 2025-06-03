<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String type = request.getParameter("type");
    String message = "";

    if ("delete".equals(type)) {
        message = "회원 정보가 삭제되었습니다.";
    } else if ("update".equals(type)) {
        message = "회원 정보가 수정되었습니다.";
    } else {
        message = "처리가 완료되었습니다.";
    }
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   

<jsp:include page="/layout/header.jsp" />

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
	</div>

<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5">
		<h1 class="text-center"><%= message %></h1>
		<div class="btn-box d-flex justify-content-center p-5">
			<a href="/" class="btn btn-lg btn-primary">메인 화면</a>
		</div>
	</div>

<jsp:include page="/layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" 
	crossorigin="anonymous"></script>
<script src="/static/js/validation.js"></script>
</body>
</html>
