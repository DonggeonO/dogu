package test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/emp")
public class EmpController extends HttpServlet {
	// 등록 또는 수정 후 공통 처리
	private void showAlertAndReload(PrintWriter out, String message) {
		// 메서드의 매개변수를 이용하여 out,message를 자동으로 호출하여 여러가지 응답에 적용알람가능
		// PrintWriter out == html/JS코드를 출력하기위한 출력 스트림 (클라이언트에게)
		// String message == 띄울 알림창 메세지 (ex/."등록 완료) (클라이언트에게)
	    out.println("<script>"); // 여기서 자바스크립트를 실행하기 
	    out.println("alert('" + message + "');");
	    // 메서드 매개변수를 이용하여 메세지내용 호출됨 
	    out.println("parent.document.searchForm.submit();");
	    //iframe 내부에서 실행할 때는 반드시 parent.document라고 해야한다. 
	    // form태그를 생성시 타겟=변수명 을주게되는데 그것은 iframe의 name로 정의되어 조회결과를 출력해주는 부모가된다 
	 // ✅ 등록/수정 폼 닫기
	    out.println("if (parent.document.getElementById('insertForm')) parent.document.getElementById('insertForm').style.display = 'none';");
	    out.println("if (parent.document.getElementById('updateForm')) parent.document.getElementById('updateForm').style.display = 'none';");

	    out.println("</script>"); // 자바스크립트 끝내기 
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
	    res.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = res.getWriter();

	    String action = req.getParameter("action");
	    EmpDAO dao = new EmpDAO();

	    try {
	        if ("list".equals(action)) {
	        	// 액션(문자열데이터값)의 값이 list와 같다면 (list는 문자열데이터입니다)
	            int deptno = Integer.parseInt(req.getParameter("deptno"));
	            //클라이언트에게 요청받은 문자열 파라미터값을 (deptno) 정수로 변환하여 저장한다.
	            List<EmpVO> list = dao.selectByDept(deptno);
	            // deptno의값을 조회하여 list에 저장한다

	            // JavaScript 포함
	            out.println("<script>");
	            out.println("function editEmployee(empno, ename, job, hiredate, deptno, sal, comm) {");
	            out.println("  parent.document.getElementById('updateForm').style.display = 'block';");
	            out.println("  parent.document.getElementById('editEmpno').value = empno;");
	            out.println("  parent.document.getElementById('editEname').value = ename;");
	            out.println("  parent.document.getElementById('editJob').value = job;");
	            out.println("  parent.document.getElementById('editHiredate').value = hiredate;");
	            out.println("  parent.document.getElementById('editComm').value = comm;");
	            out.println("  parent.document.getElementById('dept10').checked = (deptno == 10);");
	            out.println("  parent.document.getElementById('dept20').checked = (deptno == 20);");
	            out.println("  parent.document.getElementById('dept30').checked = (deptno == 30);");
	            out.println("  parent.document.getElementById('editSal').value = sal;");
	            out.println("}");
	            out.println("</script>");

	            out.println("<table border='1'>");
	            out.println("<tr><th>번호</th><th>이름</th><th>직업</th><th>입사일</th><th>부서</th><th>급여</th><th>자기소개</th><th>삭제</th><th>수정</th></tr>");
	            // 각 데이터베이스 이름에 값을받아 지정되곳에 할당하여 조회테이블을 생성하는 코드.
	            
	            
	            for (EmpVO e : list) {
	                out.println("<tr>");
	                out.println("<td>" + e.getEmpno() + "</td>");
	                out.println("<td>" + e.getEname() + "</td>");
	                out.println("<td>" + e.getJob() + "</td>");
	                out.println("<td>" + e.getHiredate() + "</td>");
	                out.println("<td>" + e.getDeptno() + "</td>");
	                out.println("<td>" + e.getSal() + "</td>");
	                out.println("<td>" + e.getComm() + "</td>");
	                out.println("<td><button onclick='if(confirm(\"정말 삭제하시겠습니까?\")) location.href=\"emp?action=delete&empno=" + e.getEmpno() + "\"'>삭제</button></td>");
	                out.println("<td><button onclick=\"editEmployee(" + e.getEmpno() + ", '" + e.getEname() + "', '" + e.getJob() + "', '" + e.getHiredate() + "', " + e.getDeptno() + ", " + e.getSal() + ", '" + e.getComm() + "')\">수정</button></td>");
	                out.println("</tr>");
	            }
	            out.println("</table>");
	            // 선택한 인물의 정보를 출력하여 수정혹은 삭제하는 코드.

	        } else if ("delete".equals(action)) {
	        	// 액션이 삭제라면
	            int empno = Integer.parseInt(req.getParameter("empno"));
	            // 요청받은 empno파라미터 값을 가져와 정수로 변화하여 저장 한다.
	            dao.delete(empno);
	            // 해당 empno 값을 삭제.
	            showAlertAndReload(out, "삭제되었습니다.");
	            // 삭제되었다는 메세지 출력 
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        out.println("문제가 발생했습니다. 관리자에게 문의하세요.");
	        // 에러 발생 out 메세지 출력 
	    }
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
	    req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = res.getWriter();

	    String action = req.getParameter("action");
	    EmpDAO dao = new EmpDAO();

	    try {
	        EmpVO emp = new EmpVO();
	        emp.setEmpno(Integer.parseInt(req.getParameter("empno")));
	        emp.setEname(req.getParameter("ename"));
	        emp.setJob(req.getParameter("job"));
	        emp.setHiredate(req.getParameter("hiredate"));
	        emp.setDeptno(Integer.parseInt(req.getParameter("deptno")));
	        emp.setSal(Double.parseDouble(req.getParameter("sal")));
	        emp.setComm(req.getParameter("comm"));

	        if ("update".equals(action)) {
	            dao.update(emp);
	            showAlertAndReload(out, "수정되었습니다.");
	        } else {
	            dao.insert(emp);
	            showAlertAndReload(out, "등록되었습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace(out);
	    }
	}
}