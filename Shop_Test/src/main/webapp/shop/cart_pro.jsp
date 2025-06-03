<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="shop.dto.Product" %>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");

    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("products.jsp?error=invalid");
        return;
    }

    ProductRepository repo = new ProductRepository();
    Product product = repo.findById(id);

    if (product == null) {
        response.sendRedirect("products.jsp?error=notfound");
        return;
    }

    List<Product> cart = (List<Product>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    boolean found = false;
    for (Product p : cart) {
        if (p.getProductId().equals(id)) {
            p.setQuantity(p.getQuantity() + 1);
            found = true;
            break;
        }
    }

    if (!found) {
        product.setQuantity(1);
        cart.add(product);
    }

    session.setAttribute("cart", cart);
    response.sendRedirect("cart.jsp");
%>
