package trainer_schedule.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import trainer_schedule.dto.MemberScheduleDTO;

public class MemberScheduleDAO {
	private static final String URL = "jdbc:mysql://localhost:3306/health";
    private static final String USER = "aloha";
    private static final String PASSWORD = "123456";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // ✅ 모든 회원 리스트 반환
    public List<MemberScheduleDTO> getAllMembers() {
        List<MemberScheduleDTO> list = new ArrayList<>();
        String sql = "SELECT member_id, name, phone FROM member ORDER BY name";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            while (rs.next()) {
            	MemberScheduleDTO dto = new MemberScheduleDTO();
                dto.setMemberId(rs.getString("member_id"));
                dto.setName(rs.getString("name"));
                dto.setPhone(rs.getString("phone"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
} 
