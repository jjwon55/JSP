package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckMemberServlet
 */
@WebServlet("/check-member")
public class CheckMemberServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] names = request.getParameterValues("memberNames[]");
        List<String> notFound = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/health", "aloha", "123456")) {
            for (String name : names) {
                PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) FROM member WHERE name = ?");
                pstmt.setString(1, name);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next() && rs.getInt(1) == 0) {
                    notFound.add(name);
                }
                rs.close();
                pstmt.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500);
            return;
        }

        if (!notFound.isEmpty()) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('없는 회원입니다: " + String.join(", ", notFound) + "');");
            out.println("history.back();");
            out.println("</script>");
        } else {
            // 이름이 모두 유효 → schedule 서블릿으로 넘김
            request.getRequestDispatcher("/schedule").forward(request, response);
        }
    }
}
