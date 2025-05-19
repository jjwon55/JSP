// TrainerScheduleServlet.java
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/ScheduleSaveServlet")
public class ScheduleSaveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/health", "aloha", "123456");
            int i = 0;

            System.out.println("=== Schedule 저장 시작: " + date + " ===");

            while (request.getParameter("entries[" + i + "].trainer") != null) {
                String trainer = request.getParameter("entries[" + i + "].trainer");
                String time = request.getParameter("entries[" + i + "].time");
                String memo = request.getParameter("entries[" + i + "].memo");
                boolean checked = "true".equals(request.getParameter("entries[" + i + "].checked"));

                System.out.println("[" + i + "] 트레이너: " + trainer + ", 시간: " + time + ", 체크됨: " + checked + ", 메모: " + memo);

                if (checked || (memo != null && !memo.trim().isEmpty())) {
                    // ✅ 저장
                    String sql = "REPLACE INTO trainer_schedule (schedule_date, trainer_name, time_range, memo, is_checked) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, date);
                    pstmt.setString(2, trainer);
                    pstmt.setString(3, time);
                    pstmt.setString(4, memo);
                    pstmt.setBoolean(5, checked);
                    pstmt.executeUpdate();
                    pstmt.close();
                } else {
                    // ✅ 삭제
                    String deleteSql = "DELETE FROM trainer_schedule WHERE schedule_date = ? AND trainer_name = ? AND time_range = ?";
                    PreparedStatement pstmt = conn.prepareStatement(deleteSql);
                    pstmt.setString(1, date);
                    pstmt.setString(2, trainer);
                    pstmt.setString(3, time);
                    pstmt.executeUpdate();
                    pstmt.close();
                }

                i++;
            }

            conn.close();
            System.out.println("=== 저장 완료 ===");
            response.sendRedirect("schedule.jsp?date=" + date);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
