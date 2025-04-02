<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!-- 위코드는 로그인 안했으면 접근 막기 위한 코드  -->
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>직원 관리 시스템 - AJAX RESTful 스타일</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    #pagination {
      margin-top: 20px;
      padding: 10px;
      text-align: center;
    }

    #pagination button {
      margin: 3px;
      padding: 5px 10px;
      font-size: 14px;
    }
  </style>
  <script>
    $(document).ready(function () {
    	// 문서가 완전히 로드된 후 실행됨
      $("input[name='searchDeptno'][value='10']").prop("checked", true);
    });
    // 라디오중 value-10인 요소를 체크 상태로 설정.(기본설정)
    
    function doService(method, page = 1) {
    	// doService 함수정의 ajax 요청을 처리하는 핵심 함수
    	// method 는 HTTP방식(GET,POST 등),page는 기본값이 1
      const deptno = $("input[name='searchDeptno']:checked").val() || "10";
    	// 체크된 searchDEptno라디오 버튼 값을 가져와 deptno에 저장 
    	// 없다면 10으로 고정값 적용 
      console.log("✅ doService 호출됨:", method, "page:", page);

      if (!deptno && method === 'GET') {
        alert("부서를 선택하세요.");
        return;
      }
      // deptno값이 없고 , method가 "GET"일 경우 알림창 발생

      let url = "/member";
      // 서버 경로를 /member로 설정
      let data = {};
      // 보낼 데이터를 담을 객체 또는 문자열 초기화
      let formSelector = '';
      // 등록 / 수정 폼의 선택자 (ID)를 담기위한 변수 (초기엔 비어있다.)

      if (method === 'GET') {
    	  // GET 요청일경우 서버에 리스트 조회 요청을 보낸다.
        data = { action: "list", deptno: deptno, page: page };
    	  //data객체에  action: "list", deptno: deptno, page: page 정보를 담는다 
    	  // → 이 값들이 /member?action=list&deptno=10&page=1 처럼 URL 파라미터로 전달됨
      } else if (method === 'POST') {
        formSelector = "#insertForm form";
        data = $(formSelector).serialize() + "&action=insert";
        
        // POST 요청일경우 formSelector에 등록 폼(#insertForm form)을 저장
        // 해당 폼의 입력값들을 serialize()로 직렬화 + 거기에 &action=insert를 추가해서 서버가 “등록 요청”임을 알 수 있게 함
      } else if (method === 'PUT') {
        formSelector = "#updateForm form";
        data = $(formSelector).serialize() + "&action=update";
        method = 'POST';
      }
      // PUT 요청일경우 업데이트 폼의 폼값을 폼셀렉터에 저장 
      // 폼셀렉터 문자열 직렬화  +  &action=update를 붙여서 서버가 “수정 요청”이라는 걸 알게 함
      // 중요한 포인트: method = 'POST'로 바꿔주는 이유는
      // -> 브라우저에서는 PUT 방식 폼 전송이 불가능하기 때문 → 서버에서 POST로 받고 action=update로 구분


      $.ajax({
        type: method,
        // 서버에 요청을 어떤 방식으로 보낼지의 방식을 정의
        url: url,
        data: data,
        // 서버로 보내는 데이터
        dataType: method === 'GET' ? 'json' : 'text',
        		// 서버로부터 응답이 어떤 형식으로 올지 기대하는 형식 
        success: function (response) {
          if (method === 'GET') {
            $('#result').html(response.html);
            renderPagination(Math.ceil(response.totalCount / 3)); // 한 페이지 3개 기준
            //renderPagination(...) => 페이지 번호 버튼을 만들어주는 함수.
          } else {
            alert("작업 완료");
            doService('GET', 1);
            // 등록 수정이 끝났으니 첫페이지부터 다시조회 요청
            $(formSelector)[0].reset();
            //저장된 폼요소 초기화 즉,입력창 안의 모든 값들을 비워주는 동작 
            $("#insertForm").hide();
            $("#updateForm").hide();
            // 등록 수정폼을 숨김
            $("input[name='searchDeptno'][value='" + deptno + "']").prop('checked', true);
            // 사용자가 등록/ 수정한 부서번호(deptno)라디오 버튼을 다시 체크 해줌.
            //checked, disabled, selected 같은 속성은 .prop()으로 제어해야 정확합니다.
          }
        },
        error: function (xhr) {
        	// 요청이 실패했을때 자동으로 넘어오는 에러 정보
          $('#result').html("에러 발생: " + xhr.statusText);
        	// xhr.statusText는 에러 메시지 예:
          //"Not Found" → 404
          //"Internal Server Error" → 500
          // #result 영역에 출력해서 사용자한테 알려주는 용도 !
        }
      });
    }

    function renderPagination(totalPages) {
    	// 페이지 번호 버튼 들을 만드는 함수
      console.log("📌 총 페이지 수:", totalPages);
    	// 콘솔에 총 페이지 수를 출력 -> 디버깅용 로그
      let html = "";
    	// html문자열을 쌓기 위한 변수 초기화
      for (let i = 1; i <= totalPages; i++) {
    	  // 1부터 totalpages까지 반복 (예: 총 3페이지면 -> 1,2,3)
        html += '<button onclick="doService(\'GET\', ' + i + ')">' + i + '</button>';
        // 페이지 번호 버튼을 만드는 핵심 코드!
        //	
      }
      $("#pagination").html(html);
      // 만들어진 버튼 HTML들을 id=pagination요소 안에 넣는다.
    }

    function confirmDelete(empno) {
    	//confirmDelete 직원삭제 기능을 처리하는 함수.
      if (confirm("정말 삭제하시겠습니까?")) {
    	  // 확인/취소 버튼이있는 알림창을 띄움
        $.get("/member", { action: "delete", empno: empno }, function () {
        	// get방식으로 요청 전송 요청할서버 경로 / 서버에 삭제 요청임을 알리는 명령/ 삭제할 대상의 사번 값 전달
          alert("삭제 완료");
          doService('GET', 1);
          // 삭제후 첫 페이지의 직원 목록을 다시 불러온다 (갱신)
        }).fail(function () {
          alert("삭제 실패");
        });
      }
    }

    function showEditForm(empno, ename, job, hiredate, deptno, sal, comm) {
    	// 선택한 직원의 정보를 수정 폼에 미리 채워 넣어 보여주는 함수.
      $("#updateForm input[name='empno']").val(empno);
      $("#updateForm input[name='ename']").val(ename);
      $("#updateForm input[name='job']").val(job);
      $("#updateForm input[name='hiredate']").val(hiredate);
      // 각각의 input에 기본 데이터를 value로 채워넣는 부분
      // 즉, 수정전 데이터 값을 보여주는 단계
      $("#updateForm input[name='deptno'][value='" + deptno + "']").prop("checked", true);
      // 라디오 버튼은 여러개중 하나만 선택 되어야 하므로 해달 value에 checked 속성을 true로 설정 
      // 셀렉트 체크드 디세이블 같은 경우는 .prop를 사용하여 현재값을 알려줘야한다.
      $("#updateForm select[name='sal']").val(sal);
      $("#updateForm textarea[name='comm']").val(comm);
      // 각 값을 미리 채워 보여주고 수정 대기 
      $("#updateForm").show();
      // 수정폼 보여주는 기능
    }

    function toggleForm(id) {
      $("#" + id).toggle();
      // 전달받은 id값을 가진 요소의 보임/숨김을 토글(toggle)
      // show() / hide() 를 자동으로 번갈아 수행
    }
    function cancelForm(formId) {
    	  $("#" + formId).hide();                   // 폼 숨기기
    	  $("#" + formId + " form")[0].reset();     // 폼 입력값 초기화
    	}
  </script>
</head>
<body>

<div>
   <h2>직원 관리 시스템 (RESTful 스타일)</h2>
   <a href="index.jsp">게시판1</a>
   <a href="index4.jsp">게시판2</a>
   <a href="index5.jsp">게시판3</a>
</div><br>

<div id="logout">
  <form action="logout.jsp" method="post" style="display:inline;">
    <input type="submit" value="로그아웃">
  </form>
</div>

<p>
  부서번호:
  <label><input type="radio" name="searchDeptno" value="10">10</label>
  <label><input type="radio" name="searchDeptno" value="20">20</label>
  <label><input type="radio" name="searchDeptno" value="30">30</label>
  <button onclick="doService('GET', 1)">조회(GET)</button>
  <button onclick="toggleForm('insertForm')">직원 등록</button>
</p>

<!-- 등록 폼 -->
<div id="insertForm" style="display:none">
  <h3>등록 (POST)</h3>
  <form onsubmit="event.preventDefault(); doService('POST');">
    사번: <input type="text" name="empno"><br>
    이름: <input type="text" name="ename"><br>
    직업: <input type="text" name="job"><br>
    입사일: <input type="date" name="hiredate"><br>
    부서번호:
    <label><input type="radio" name="deptno" value="10">10</label>
    <label><input type="radio" name="deptno" value="20">20</label>
    <label><input type="radio" name="deptno" value="30">30</label><br>
    월급:
    <select name="sal" required>
      <option value="">--선택--</option>
      <option value="2200">2200</option>
      <option value="2400">2400</option>
      <option value="2600">2600</option>
      <option value="3000">3000</option>
      <option value="4000">4000</option>
      <option value="5000">5000</option>
      <option value="6000">6000</option>
    </select><br>
    자기소개:<br>
    <textarea name="comm" rows="5" cols="50"></textarea><br>
    <button type="submit">등록</button>
     <button type="button" onclick="cancelForm('insertForm')">취소</button>
  </form>
</div>

<!-- 수정 폼 -->
<div id="updateForm" style="display:none">
  <h3>수정 (PUT)</h3>
  <form onsubmit="event.preventDefault(); doService('PUT');">
    사번(수정 기준): <input type="text" name="empno" readonly><br>
    이름: <input type="text" name="ename"><br>
    직업: <input type="text" name="job"><br>
    입사일: <input type="date" name="hiredate"><br>
    부서번호:
    <label><input type="radio" name="deptno" value="10">10</label>
    <label><input type="radio" name="deptno" value="20">20</label>
    <label><input type="radio" name="deptno" value="30">30</label><br>
    월급:
    <select name="sal" required>
      <option value="">--선택--</option>
      <option value="2200">2200</option>
      <option value="2400">2400</option>
      <option value="2600">2600</option>
      <option value="3000">3000</option>
      <option value="4000">4000</option>
      <option value="5000">5000</option>
      <option value="6000">6000</option>
    </select><br>
    자기소개:<br>
    <textarea name="comm" rows="5" cols="50"></textarea><br>
    <button type="submit">수정</button>
    <button type="button" onclick="cancelForm('updateForm')">취소</button>
  </form>
</div>

<!-- 결과 출력 영역 -->
<div id="result" style="margin-top:20px ; border:1px solid #ccc; padding:10px; "></div>

<!-- 페이지 버튼 영역 -->
<div id="pagination"></div>

</body>
</html>
