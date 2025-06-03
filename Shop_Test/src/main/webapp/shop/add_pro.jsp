<%@ page import="shop.dto.Product" %>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="java.io.File" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	// 파일 저장 경로 (서버 /upload 폴더 기준)
	String uploadPath = application.getRealPath("/upload");
	File uploadDir = new File(uploadPath);
	if (!uploadDir.exists()) uploadDir.mkdirs();

	// 업로드된 파일 처리
	Part part = request.getPart("file");
	String fileName = part.getSubmittedFileName();
	String savedFilePath = "";  // 파일 이름만 저장할 예정 (DB에는 파일명만)

	if (fileName != null && !fileName.isEmpty()) {
		// 저장 경로: /upload/파일명
		File savedFile = new File(uploadPath, fileName);
		part.write(savedFile.getAbsolutePath());
		savedFilePath = fileName;
	}

	// 파라미터 수집
	String productId = request.getParameter("productId");
	String name = request.getParameter("name");
	int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
	String description = request.getParameter("description");
	String manufacturer = request.getParameter("manufacturer");
	String category = request.getParameter("category");
	long unitsInStock = Long.parseLong(request.getParameter("unitsInStock"));
	String condition = request.getParameter("condition");

	// DTO에 저장
	Product product = new Product();
	product.setProductId(productId);
	product.setName(name);
	product.setUnitPrice(unitPrice);
	product.setDescription(description);
	product.setManufacturer(manufacturer);
	product.setCategory(category);
	product.setUnitsInStock(unitsInStock);
	product.setCondition(condition);
	product.setFile(savedFilePath);  // 파일 이름만 저장

	// DAO 등록
	ProductRepository repo = new ProductRepository();
	boolean result = repo.insert(product);  // insert() 구현 필요

	// 결과에 따라 이동
	if (result) {
		response.sendRedirect("product.jsp");  // 상품 목록 페이지
	} else {
		response.sendRedirect("add.jsp?error=fail");  // 실패 시 등록 페이지로
	}
%>
