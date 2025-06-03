<%@page import="shop.dto.Product"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
<jsp:include page="/layout/header.jsp" />

<%
	List<Product> cart = (List<Product>) session.getAttribute("cart");
	int total = 0;
	int count = 0;
	String cartId = "027CB9481FF743CC8FB11365BB289DFB"; // 예시 고정 UUID
%>

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
	<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">장바구니 목록 입니다.</p>
	</div>
</div>

<!-- 장바구니 영역 -->
<div class="container order">
	<table class="table table-striped table-hover table-bordered text-center align-middle">
		<thead>
			<tr class="table-primary">
				<th>상품</th>
				<th>가격</th>
				<th>수량</th>
				<th>소계</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<%
				if (cart != null && !cart.isEmpty()) {
					for (Product p : cart) {
						int subtotal = p.getUnitPrice() * p.getQuantity();
						total += subtotal;
						count += p.getQuantity();
			%>
				<tr>
					<td><%= p.getName() %></td>
					<td><%= p.getUnitPrice() %></td>
					<td><%= p.getQuantity() %></td>
					<td><%= subtotal %></td>
					<td>
						<a href="deleteCart.jsp?id=<%= p.getProductId() %>" class="btn btn-danger">삭제</a>
					</td>
				</tr>
			<%
					}
				} else {
			%>
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>
				</tr>
			<% } %>
		</tbody>
		<tfoot>
			<tr>
				<td></td>
				<td></td>
				<td>총액</td>
				<td id="cart-sum"><%= total %></td>
				<td></td>
			</tr>
		</tfoot>
	</table>

	<div class="d-flex justify-content-between align-items-center p-3">
		<a href="deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-lg btn-danger">전체삭제</a>
		<a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" />
<script src="/static/js/validation.js"></script>

<script>
	let cartId = '<%= cartId %>';
	let cartCount = '<%= count %>';
	let cartSum = document.getElementById('cart-sum');

	function order() {
		if (cartCount == 0) {
			alert('장바구니에 담긴 상품이 없습니다.');
			return;
		}
		let msg = '총 ' + cartCount + '개의 상품을 주문합니다.\n총 주문금액 : ' + cartSum.textContent;
		let check = confirm(msg);
		if (check) {
			location.href = 'ship.jsp?cartId=' + cartId;
		}
	}
</script>

</body>
</html>
