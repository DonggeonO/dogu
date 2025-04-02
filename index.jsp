<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>직원 관리 시스템 - AJAX</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    function loadEmployees() {
        const deptno = $("input[name='deptno']:checked").val();
        if (!deptno) {
            alert("조회할 부서를 먼저 선택해주세요");
            return;
        }
        $.get("/member", { action: "list", deptno: deptno, page: 1 }, function (data) {
            const parsed = typeof data === 'string' ? JSON.parse(data) : data;
            $("#resultContainer").html(parsed.html);
            renderPagination(Math.ceil(parsed.totalCount / 3));
        });
    }

    function renderPagination(totalPages) {
        let html = "";
        for (let i = 1; i <= totalPages; i++) {
            html += '<button onclick="loadPage(' + i + ')">' + i + '</button> ';
        }
        $("#pagination").html(html);
    }

    function loadPage(page) {
        const deptno = $("input[name='deptno']:checked").val();
        $.get("/member", { action: "list", deptno: deptno, page: page }, function (data) {
            const parsed = typeof data === 'string' ? JSON.parse(data) : data;
            $("#resultContainer").html(parsed.html);
        });
    }

    function toggleInsertForm() {
        $("#insertForm").toggle();
    }

    function registerEmployee() {
        const formData = $("#insertForm form").serialize();
        $.post("/member", formData + "&action=insert", function () {
            alert("등록 완료");
            document.querySelector("#insertForm form").reset();
            $("#insertForm").hide();
            loadEmployees();
        }).fail(function () {
            alert("등록 실패");
        });
    }

    function showEditForm(empno, ename, job, hiredate, deptno, sal, comm) {
        $("#updateForm").show();
        $("#editEmpno").val(empno);
        $("#editEname").val(ename);
        $("#editJob").val(job);
        $("#editHiredate").val(hiredate);
        $("#editComm").val(comm);
        $("#dept10").prop("checked", deptno == 10);
        $("#dept20").prop("checked", deptno == 20);
        $("#dept30").prop("checked", deptno == 30);
        $("#editSal").val(sal);
    }

    function updateEmployee() {
        const formData = $("#updateForm form").serialize();
        $.post("/member", formData + "&action=update", function () {
            alert("수정 완료");
            $("#updateForm").hide();
            loadEmployees();
        }).fail(function () {
            alert("수정 실패");
        });
    }

    function confirmDelete(empno) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.get("/member", { action: "delete", empno: empno }, function () {
                alert("삭제 완료");
                loadEmployees();
            }).fail(function () {
                alert("삭제 실패");
            });
        }
    }
    function cancelForm(formId) {
  	  $("#" + formId).hide();                   // 폼 숨기기
  	  $("#" + formId + " form")[0].reset();     // 폼 입력값 초기화
  	}
    </script>
</head>
<body>

<div>
   <h1>직원 관리 시스템 - AJAX</h1>
   <a href="index.jsp">게시판1</a>
   <a href="index4.jsp">게시판2</a>
   <a href="index5.jsp">게시판3</a>
</div><br>

<div id="logout">
  <form action="logout.jsp" method="post" style="display:inline;">
    <input type="submit" value="로그아웃">
  </form>
</div>
<!-- 조회 -->
<label>부서 번호:</label>
<label><input type="radio" name="deptno" value="10">10</label>
<label><input type="radio" name="deptno" value="20">20</label>
<label><input type="radio" name="deptno" value="30">30</label>
<button onclick="loadEmployees()">조회</button>
<button onclick="toggleInsertForm()">직원 등록</button>

<!-- 등록 폼 -->
<div id="insertForm" style="display: none; margin-top: 20px;">
    <form onsubmit="event.preventDefault(); registerEmployee();">
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
        <button type="button" onclick="cancelForm('insertForm')">취소</button>
    </form>
</div>

<!-- 수정 폼 -->
<div id="updateForm" style="display: none; margin-top: 20px;">
    <form onsubmit="event.preventDefault(); updateEmployee();">
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
        <button type="button" onclick="cancelForm('updateForm')">취소</button>
    </form>
</div>

<!-- 결과 출력 영역 -->
<div id="resultContainer" style="margin-top: 30px;"></div>
<div id="pagination" style="margin-top: 20px;"></div>
</body>
</html>
