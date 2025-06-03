<%@ page import="shop.dao.ProductRepository" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String productId = request.getParameter("id");

    if (productId != null && !productId.trim().isEmpty()) {
        ProductRepository repo = new ProductRepository();
        boolean deleted = repo.delete(productId);  // delete(String id) 메서드가 있어야 함

        if (deleted) {
            // 삭제 성공 → 상품 목록(또는 편집 페이지)로 이동
            response.sendRedirect("products.jsp");
        } else {
            // 실패 시 다시 상품 편집 페이지로
            response.sendRedirect("editProduct.jsp?id=" + productId + "&error=deleteFail");
        }
    } else {
        response.sendRedirect("products.jsp?error=invalidId");
    }
%>
