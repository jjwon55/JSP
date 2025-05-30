package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ScheduleSaveServlet")
public class ScheduleSaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지
        String date = request.getParameter("date");

        System.out.println("=== Schedule 저장 시작: " + date + " ===");

        try (
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/health", "aloha", "123456")
        ) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            int i = 0;

            while (request.getParameter("entries[" + i + "].trainer") != null) {
                String trainer = request.getParameter("entries[" + i + "].trainer");
                String time = request.getParameter("entries[" + i + "].time");
                String memo = request.getParameter("entries[" + i + "].memo");
                boolean checked = "true".equals(request.getParameter("entries[" + i + "].checked"));

                System.out.printf("[%d] 트레이너: %s, 시간: %s, 체크됨: %s, 메모: %s%n",
                        i, trainer, time, checked, memo);

                if (checked || (memo != null && !memo.trim().isEmpty())) {
                    // 저장 또는 덮어쓰기
                    try (PreparedStatement pstmt = conn.prepareStatement(
                        "REPLACE INTO trainer_schedule (schedule_date, trainer_name, time_range, memo, is_checked) VALUES (?, ?, ?, ?, ?)")
                    ) {
                        pstmt.setString(1, date);
                        pstmt.setString(2, trainer);
                        pstmt.setString(3, time);
                        pstmt.setString(4, memo);
                        pstmt.setBoolean(5, checked);
                        pstmt.executeUpdate();
                    }
                } else {
                    // 저장된 항목 삭제
                    try (PreparedStatement pstmt = conn.prepareStatement(
                        "DELETE FROM trainer_schedule WHERE schedule_date = ? AND trainer_name = ? AND time_range = ?")
                    ) {
                        pstmt.setString(1, date);
                        pstmt.setString(2, trainer);
                        pstmt.setString(3, time);
                        pstmt.executeUpdate();
                    }
                }

                i++;
            }

            System.out.println("=== 저장 완료 ===");
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('예약이 완료되었습니다.');");
            out.println("location.href='schedule.jsp?date=" + date + "';");
            out.println("</script>");

        } catch (Exception e) {
            System.err.println("⛔ Schedule 저장 중 오류 발생:");
            e.printStackTrace();
        }
    }
}
