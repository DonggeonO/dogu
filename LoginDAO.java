package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {

	private static final String URL = "jdbc:sqlite:D:/apache-tomcat-9.0.100/sample.db";

	// 로그인 기능
	public LoginVO login(String id, String password) {
		LoginVO vo = null;
		String sql = "SELECT * FROM user WHERE id = ? AND password = ?";

		try (Connection conn = DriverManager.getConnection(URL); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, id);
			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				vo = new LoginVO(rs.getString("id"), rs.getString("password"), rs.getString("name"),
						rs.getString("email"), rs.getString("regDate"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}

	// ✅ 여기에 main 추가 (테스트용)
	public static void main(String[] args) {
		try (Connection conn = DriverManager.getConnection(URL)) {
			System.out.println("✔ DB 연결 성공");

			String sql = "SELECT * FROM user";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				System.out.println("✅ 사용자 ID: " + rs.getString("id"));
			}

		} catch (Exception e) {
			System.out.println("❌ DB 연결 실패");
			e.printStackTrace();
		}
	}
}
