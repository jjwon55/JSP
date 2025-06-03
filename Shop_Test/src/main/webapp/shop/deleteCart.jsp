<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="shop.dto.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<Product> cart = (List<Product>) session.getAttribute("cart");

    String id = request.getParameter("id");         // 개별 상품 삭제용
    String cartId = request.getParameter("cartId"); // 전체 삭제용

    if (cart != null) {
        if (id != null) {
            // 개별 삭제
            Iterator<Product> it = cart.iterator();
            while (it.hasNext()) {
                Product p = it.next();
                if (p.getProductId().equals(id)) {
                    it.remove();
                    break;
                }
            }
        } else if (cartId != null) {
            // 전체 삭제
            cart.clear();
        }
        session.setAttribute("cart", cart);  // 갱신
    }

    response.sendRedirect("cart.jsp");
%>
