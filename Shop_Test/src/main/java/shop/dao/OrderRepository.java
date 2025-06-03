package shop.dao;

import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		String sql =  "INSERT INTO order(order_no, ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone)"
							+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, order.getOrderNo());
			psmt.setString(2, order.getZipCode());
			psmt.setString(3, order.getCountry());
			psmt.setString(4, order.getAddress());
			psmt.setString(5, order.getDate());
			psmt.setString(6, order.getOrderPw());
			psmt.setString(7, order.getUserId());
			psmt.setInt(8, order.getTotalPrice());
			psmt.setString(9, order.getPhone());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("주문 등록시, 오류발생");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int result = 0;
		String sql = "SELECT MAX(order_no) FROM order";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
		System.err.println("최근 등록한 orderNo 조회 중 오류");
		e.printStackTrace();
		}
		return result;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		String sql = """
					SELECT p.product_id, p.name, p.unit_price, pi.amount
			    	FROM `order` o
				    JOIN product_io pi ON o.order_no = pi.order_no
				    JOIN product p ON pi.product_id = p.product_id
				    WHERE o.user_id = ? AND pi.type = 'OUT'
					""";
		try {
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		
		
	}
	
}






























