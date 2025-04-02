package test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member")
public class EmpServlet extends HttpServlet {
	private static final String DB_URL = "jdbc:sqlite:D:/apache-tomcat-9.0.100/sample.db";

	@Override
	public void init() throws ServletException {
		// throws ServletException == 이 예외는 내가 처리하지 않고, 호출한 톰캣(서버)이 알아서 처리하도록 넘기겠다.
		try {
			Class.forName("org.sqlite.JDBC"); // ✅ JDBC 드라이버 강제 로딩
			// 해당 클래스의 static블러크를 실행하라는 뜻 class.forname
			// class.forname(...) 을 사용하면 강제로 메모리를 올린다.
			System.out.println("JDBC 드라이버 초기 로딩 완료");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// printStackTrace()메서드 :: 한줄 한줄 거신에 올린면서 보여주는 로그 // 어느 클래스의 몇번째 줄에서 터짓되었는지 알려주는
			// 메서드.
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// throws IOException = 입출력 작업중에 문제가 생겼을때 호출한 종이 에러를 발생시한다
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		try {
			if ("list".equals(action)) {
				// list라는 문자열 action에 할당된 값이 list문자열과 같은지 비교 하는 조건
				String deptParam = request.getParameter("deptno");
				String pageParam = request.getParameter("page");

				if (deptParam == null || deptParam.isEmpty() || pageParam == null || pageParam.isEmpty()) {
					response.setContentType("text/plain;charset=UTF-8");
					response.getWriter().print("잘못된 요청: 부서번호 또는 페이지 번호가 없습니다.");
					return;
				}

				int deptno = Integer.parseInt(deptParam);
				int page = Integer.parseInt(pageParam);
				int limit = 3;
				int offset = (page - 1) * limit;
				int totalCount = 0;

				StringBuilder html = new StringBuilder();

				try (Connection conn = DriverManager.getConnection(DB_URL)) {
					// 전체 건수 계산
					String countSql = "SELECT COUNT(*) FROM emp WHERE deptno = ?";
					try (PreparedStatement countStmt = conn.prepareStatement(countSql)) {
						countStmt.setInt(1, deptno);
						ResultSet countRs = countStmt.executeQuery();
						if (countRs.next()) {
							totalCount = countRs.getInt(1);
						}
					}

					// 현재 페이지 데이터 가져오기
					String sql = "SELECT * FROM emp WHERE deptno = ? LIMIT ? OFFSET ?";
					try (PreparedStatement stmt = conn.prepareStatement(sql)) {
						stmt.setInt(1, deptno);
						stmt.setInt(2, limit);
						stmt.setInt(3, offset);
						ResultSet rs = stmt.executeQuery();

						html.append("<table border='1'>");
						html.append("<tr><th>사번</th><th>이름</th><th>직업</th><th>입사일</th><th>부서</th><th>월금</th><th>소계</th><th>삭제</th><th>수정</th></tr>");

						while (rs.next()) {
							int empno = rs.getInt("empno");
							String ename = rs.getString("ename");
							String job = rs.getString("job");
							String hiredate = rs.getString("hiredate");
							int dno = rs.getInt("deptno");
							double sal = rs.getDouble("sal");
							String comm = rs.getString("comm");

							html.append("<tr>");
							html.append("<td>" + empno + "</td>");
							html.append("<td>" + ename + "</td>");
							html.append("<td>" + job + "</td>");
							html.append("<td>" + hiredate + "</td>");
							html.append("<td>" + dno + "</td>");
							html.append("<td>" + sal + "</td>");
							html.append("<td>" + comm + "</td>");
							html.append("<td><button onclick='confirmDelete(" + empno + ")'>삭제</button></td>");
							html.append("<td><button onclick=\"showEditForm(" + empno + ", '" + ename + "', '" + job + "', '" + hiredate + "', " + dno + ", " + sal + ", '" + comm + "')\">수정</button></td>");
							html.append("</tr>");
						}
						html.append("</table>");
					}
				}

				// JSON으로 반환
				response.setContentType("application/json;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.print("{");
				out.print("\"html\": \"" + html.toString().replace("\"", "\\\"").replace("\n", "") + "\",");
				out.print("\"totalCount\": " + totalCount);
				out.print("}");
			} else if ("delete".equals(action)) {
				int empno = Integer.parseInt(request.getParameter("empno"));
				try (Connection conn = DriverManager.getConnection(DB_URL);
					 PreparedStatement stmt = conn.prepareStatement("DELETE FROM emp WHERE empno = ?")) {
					stmt.setInt(1, empno);
					stmt.executeUpdate();
					response.getWriter().print("삭제 완료");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("오류: " + e.getMessage());
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		try (Connection conn = DriverManager.getConnection(DB_URL)) {
			// conn객체에 db연결 접속
			if ("insert".equals(action)) {
				// 액션이 insert일경우 조건문 = 클라이언트가 직원등록을 누르로 요청 보내는 상황 확인
				String sql = "INSERT INTO emp (empno, ename, job, hiredate, deptno, sal, comm) VALUES (?, ?, ?, ?, ?, ?, ?)";
				try (PreparedStatement stmt = conn.prepareStatement(sql)) {
					stmt.setInt(1, Integer.parseInt(request.getParameter("empno")));
					stmt.setString(2, request.getParameter("ename"));
					stmt.setString(3, request.getParameter("job"));
					stmt.setString(4, request.getParameter("hiredate"));
					stmt.setInt(5, Integer.parseInt(request.getParameter("deptno")));
					stmt.setDouble(6, Double.parseDouble(request.getParameter("sal")));
					stmt.setString(7, request.getParameter("comm"));
					stmt.executeUpdate();
				}
				response.getWriter().print("등록 완료");
			} else if ("update".equals(action)) {
				String sql = "UPDATE emp SET ename=?, job=?, hiredate=?, deptno=?, sal=?, comm=? WHERE empno=?";
				try (PreparedStatement stmt = conn.prepareStatement(sql)) {
					stmt.setString(1, request.getParameter("ename"));
					stmt.setString(2, request.getParameter("job"));
					stmt.setString(3, request.getParameter("hiredate"));
					stmt.setInt(4, Integer.parseInt(request.getParameter("deptno")));
					stmt.setDouble(5, Double.parseDouble(request.getParameter("sal")));
					stmt.setString(6, request.getParameter("comm"));
					stmt.setInt(7, Integer.parseInt(request.getParameter("empno")));
					stmt.executeUpdate();
				}
				response.getWriter().print("수정 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("오류: " + e.getMessage());
		}
	}
}
