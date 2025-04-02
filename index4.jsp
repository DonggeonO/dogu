<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>직원 관리 시스템2</title>
    <script>
        function toggleInsertForm() {
            const form = document.getElementById("insertForm");
            
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }

        function editEmployee(empno, ename, job, hiredate, deptno, sal, comm) {
            document.getElementById("updateForm").style.display = "block";
            document.getElementById("editEmpno").value = empno;
            document.getElementById("editEname").value = ename;
            document.getElementById("editJob").value = job;
            document.getElementById("editHiredate").value = hiredate;
            document.getElementById("editComm").value = comm;
            document.getElementById("dept10").checked = (deptno == 10);
            document.getElementById("dept20").checked = (deptno == 20);
            document.getElementById("dept30").checked = (deptno == 30);
            document.getElementById("editSal").value = sal;
        }

        function confirmDelete(empno) {
            if (confirm("정말 삭제하시겠습니까?")) {
                location.href = "/emp?action=delete&empno=" + empno;
            }
        }
    </script>
</head>
<body>
    <div>
   <h1>직원 관리 시스템 - 서블릿 각목적에맞게 나눠서 파일생성</h1>
   <a href="index.jsp">게시판1</a>
   <a href="index4.jsp">게시판2</a>
   <a href="index5.jsp">게시판3</a>
</div><br>

<div id="logout">
  <form action="logout.jsp" method="post" style="display:inline;">
    <input type="submit" value="로그아웃">
  </form>
</div>
    <!-- 조회 폼 -->
    <form name="searchForm" method="get" action="/emp" target="resultFrame">
        <label>부서 번호:</label>
        <input type="number" name="deptno" min="10" max="30" step="10" required>
        <input type="hidden" name="action" value="list">
        <button type="submit">조회</button>
        <button type="button" onclick="toggleInsertForm()">직원 등록</button>
    </form>

    <!-- 등록 폼 -->
    <div id="insertForm" style="display: none; margin-top: 20px;">
        <form method="post" action="/emp" target="hiddenFrame" onsubmit="setTimeout(() => this.reset(), 100)">
            <input type="hidden" name="action" value="insert">
            <p>직원번호: <input type="text" name="empno" required></p>
            <p>이름: <input type="text" name="ename" required></p>
            <p>직업: <input type="text" name="job"></p>
            <p>입사일: <input type="date" name="hiredate" required></p>
            <p>부서번호:
                <input type="radio" name="deptno" value="10" required>10
                <input type="radio" name="deptno" value="20">20
                <input type="radio" name="deptno" value="30">30
            </p>
            <p>월급:
                <select name="sal">
                    <option value="2000">2000</option>
                    <option value="2200">2200</option>
                    <option value="2600">2600</option>
                    <option value="3000">3000</option>
                    <option value="4000">4000</option>
                    <option value="5000">5000</option>
                    <option value="6000">6000</option>
                </select>
            </p>
            <p>자기소개:<br>
                <textarea name="comm" rows="5" cols="40"></textarea>
            </p>
            <button type="submit">등록</button>
        </form>
    </div>

    <!-- 수정 폼 -->
    <div id="updateForm" style="display: none; margin-top: 20px;">
        <form method="post" action="/emp" target="hiddenFrame">
            <input type="hidden" name="action" value="update">
            <p>직원번호: <input type="text" name="empno" id="editEmpno" readonly></p>
            <p>이름: <input type="text" name="ename" id="editEname" required></p>
            <p>직업: <input type="text" name="job" id="editJob"></p>
            <p>입사일: <input type="date" name="hiredate" id="editHiredate" required></p>
            <p>부서번호:
                <input type="radio" name="deptno" value="10" id="dept10">10
                <input type="radio" name="deptno" value="20" id="dept20">20
                <input type="radio" name="deptno" value="30" id="dept30">30
            </p>
            <p>월급:
                <select name="sal" id="editSal">
                    <option value="2000">2000</option>
                    <option value="2200">2200</option>
                    <option value="2600">2600</option>
                    <option value="3000">3000</option>
                    <option value="4000">4000</option>
                    <option value="5000">5000</option>
                    <option value="6000">6000</option>
                </select>
            </p>
            <p>자기소개:<br>
                <textarea name="comm" id="editComm" rows="5" cols="40"></textarea>
            </p>
            <button type="submit">수정</button>
        </form>
    </div>

    <!-- 조회 결과 iframe -->
    <iframe name="resultFrame" width="100%" height="400"></iframe>

    <!-- 등록/수정용 숨김 처리 iframe -->
    <iframe name="hiddenFrame" style="display:none;"></iframe>

</body>
</html>
