<!-- 로그인 처리 -->
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if (loginUser == null) {
		response.sendRedirect("login.jsp?error=invalid");
		return;
	}
	// 로그인 성공
	// - 세션에 아이디 등록
	session.setAttribute("loginUser", loginUser);

	// 아이디 저장
	String rememberId = request.getParameter("rememberId");
	if ("on".equals(rememberId)) {
		Cookie idCookie = new Cookie("rememberId", URLEncoder.encode(id, "UTF-8"));
		idCookie.setMaxAge(60 * 60 * 24 * 7); // 7일 유지
		response.addCookie(idCookie);
	} else {
		Cookie idCookie = new Cookie("rememberId", "");
		idCookie.setMaxAge(0); // 삭제
		response.addCookie(idCookie);
	}
	
	// 자동 로그인
	String autoLogin = request.getParameter("autoLogin");
	if ("on".equals(autoLogin)) {
		String token = UUID.randomUUID().toString();
		Cookie autoCookie = new Cookie("autoLoginToken", token);
		autoCookie.setMaxAge(60 * 60 * 24 * 7); // 7일 유지
		response.addCookie(autoCookie);
	}
	// 쿠키 전달
	
	// 로그인 성공 페이지로 이동
	response.sendRedirect("complete.jsp?msg=0");		

%>





