// 2. EmpDAO.java
package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmpDAO {
	private static final String DB_URL = "jdbc:sqlite:/D:/apache-tomcat-9.0.100/sample.db";

	// ✅ 드라이버를 클래스가 로딩될 때 한 번만 등록하도록 static 블록 사용
	static {
		try {
			Class.forName("org.sqlite.JDBC");
			System.out.println("SQLite JDBC 드라이버 로딩 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<EmpVO> selectByDept(int deptno) throws Exception {
		// 특정 부서 번호 (deptno)에 속한 직원 목록을 조회해서 List<EmpVO>로 반환한다.

		List<EmpVO> list = new ArrayList<>();
		// 결과를 담을 그릇 먼저 준비.
		try (Connection conn = DriverManager.getConnection(DB_URL)) {
			// DB연결은 무조건 먼저 잡아놓고
			String sql = "SELECT * FROM emp WHERE deptno = ?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				// 쿼리 만들고,? 는 나중에 채우자
				ps.setInt(1, deptno);
				// ? 자리에 값 채움 (deptno)
				ResultSet rs = ps.executeQuery();
				// ps.executeQuery(); 메서드--> SELECT 쿼리를 실행해서 , 결과 (ResultSet)를 받아오는 메서드.
				// 쿼리에 필요한 값은 set으로 채워주고, 실행은 executeQuery()
				// 실행하면 결과가 ResultSet으로 나옴.
				while (rs.next()) {
					EmpVO e = new EmpVO(); // 한줄 = 한명의 직워 VO 객체로 변환
					e.setEmpno(rs.getInt("empno"));
					e.setEname(rs.getString("ename"));
					e.setJob(rs.getString("job"));
					e.setHiredate(rs.getString("hiredate"));
					e.setDeptno(rs.getInt("deptno"));
					e.setSal(rs.getDouble("sal"));
					e.setComm(rs.getString("comm"));
					list.add(e); // 리스트에담아 나중에 return
					// 한 줄씩 읽어서 VO에 담고,List에 모아야지!
				}
			}
		}
		return list;
	}

	public void insert(EmpVO emp) throws Exception {
		try (Connection conn = DriverManager.getConnection(DB_URL)) {
			String sql = "INSERT INTO emp (empno, ename, job, hiredate, deptno, sal, comm) VALUES (?, ?, ?, ?, ?, ?, ?)";

			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, emp.getEmpno());
				ps.setString(2, emp.getEname());
				ps.setString(3, emp.getJob());
				ps.setString(4, emp.getHiredate());
				ps.setInt(5, emp.getDeptno());
				ps.setDouble(6, emp.getSal());
				ps.setString(7, emp.getComm());
				ps.executeUpdate();
			}
		}
	}

	public void update(EmpVO emp) throws Exception {
		try (Connection conn = DriverManager.getConnection(DB_URL)) {
			// 수정은 하나의 특정 요소만 수정해야하므로 where를 사용하여 수정할수있게 해야하며 where가없으면 전체적으로 변경이되므로 주의해야한다
			String sql = "UPDATE emp SET ename=?, job=?, hiredate=?, deptno=?, sal=?, comm=? WHERE empno=?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, emp.getEname());
				ps.setString(2, emp.getJob());
				ps.setString(3, emp.getHiredate());
				ps.setInt(4, emp.getDeptno());
				ps.setDouble(5, emp.getSal());
				ps.setString(6, emp.getComm());
				ps.setInt(7, emp.getEmpno());
				ps.executeUpdate();
			}
		}
	}

	public void delete(int empno) throws Exception {
		try (Connection conn = DriverManager.getConnection(DB_URL)) {
			String sql = "DELETE FROM emp WHERE empno=?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, empno);
				ps.executeUpdate();
			}
		}
	}
}