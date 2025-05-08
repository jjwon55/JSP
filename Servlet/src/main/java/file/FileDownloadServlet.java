package file;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/download")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String fileName = request.getParameter("fileName");
		
		if (fileName == null || fileName.isEmpty()) {
			response.getWriter().println("파일명이 지정되지 않았습니다.");
			return;
		}
		
		String downloadDir = "C:\\fileupload";
		String downloadFilePath = downloadDir + File.separator + fileName;
		File file = new File(downloadFilePath);
		
		if (!file.exists()) {
			response.getWriter().println("파일이 존재하지 않습니다.");
			return;
		}
	
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/octet-stream");
		fileName = URLEncoder.encode(fileName, "UTF-8");
		response.setHeader("Content-Disposition", 
						"attachment; filename=\"" + fileName + "\"");
		
		//파일 다운로드
		// Client <-- ServletOutputStream <-- *Server <-- FileInputStream --- File System
		try {
			FileInputStream fis = new FileInputStream(file);
			ServletOutputStream sos = response.getOutputStream();
			
			byte[] buffer = new byte[4096];
			int data = -1;
			while ( (data = fis.read(buffer)) != -1) {
				sos.write(buffer, 0, data);
			}
			fis.close();
			sos.close();
		} catch (Exception e) {
			System.err.println("파일 다운로드 중 에러 발생!");
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
