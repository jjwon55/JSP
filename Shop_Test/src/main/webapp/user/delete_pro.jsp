<%@ page import="shop.dao.UserRepository" %>
<%@ page import="shop.dto.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 세션에서 로그인한 사용자 가져오기
    User loginUser = (User) session.getAttribute("loginUser");
    String id = loginUser.getId();

    // 2. 회원 삭제 처리
    UserRepository userDAO = new UserRepository();
    boolean success = userDAO.delete(id);

    // 3. 처리 결과에 따라 분기
    if (success) {
        session.invalidate(); 
        response.sendRedirect("goodbye.jsp"); 
    } else {
        response.sendRedirect("mypage.jsp?error=deleteFail");
    }
%>
