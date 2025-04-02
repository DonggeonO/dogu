<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>직원 관리 로그인</title>
  <style>
    /* CSS 그대로 유지하되 일부 스타일 간단화 가능 */
    * {
      margin: 0;
      padding: 0;
    }

    body {
      height: 100vh;
      background-color: #f2f2f2;
      background-image: repeating-linear-gradient(
        45deg,
        #ffffff,
        #ffffff 10px,
        #e6e6e6 10px,
        #e6e6e6 20px
      );
    }

    #container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 50vh;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }

    #left {
      width: 500px;
      height: 600px;
      border: none;
      border-radius: 3% 0 0 3%;
      box-shadow: -2px -4px 3px rgba(17, 14, 155, 0.2);
      overflow: hidden;
    }

    #right {
      width: 600px;
      height: 600px;
      text-align: center;
      border: 1px solid rgba(209, 208, 208, 0.7);
      box-shadow: -2px -2px 3px rgba(17, 14, 155, 0.2);
      border-radius: 0 3% 3% 0;
      border-left: none;
      background-color: white;
    }

    #btn {
      width: 400px;
      height: 50px;
      border-radius: 5px;
      border: none;
      background-color: rgb(103, 115, 221);
      color: white;
      font-size: 18px;
      font-weight: 900;
    }

    #box {
      margin: auto;
      width: 600px;
      height: 250px;
      position: relative;
      top: 50%;
      transform: translate(0, -50%);
    }

    #box1 > input {
      padding-left: 10px;
      margin-bottom: 10px;
      font-size: 15px;
      width: 400px;
      height: 50px;
      border: 1px solid #808080;
      border-radius: 10px;
      outline: none;
    }

    span {
      width: 400px;
      font-size: 40px;
      margin: auto;
      display: block;
      text-align: start;
      font-weight: 900;
    }

    #box2 {
      width: 400px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: auto;
      font-size: 13px;
    }

    #box3 > a {
      margin: 0 10px;
      color: black;
      text-decoration: none;
    }

    #box3 > a:visited {
      color: purple;
    }

    #box3 > a:hover {
      text-decoration: underline;
    }

  </style>

  <script>
    window.onload = function () {
      const savedId = localStorage.getItem("savedId");
      const userIdInput = document.getElementById("userId");
      const saveCheck = document.getElementById("saveId");

      if (savedId) {
        userIdInput.value = savedId;
        saveCheck.checked = true;
      }

      saveCheck.addEventListener("change", function () {
        if (this.checked) {
          localStorage.setItem("savedId", userIdInput.value);
        } else {
          localStorage.removeItem("savedId");
        }
      });

      userIdInput.addEventListener("input", function () {
        if (saveCheck.checked) {
          localStorage.setItem("savedId", userIdInput.value);
        }
      });
    };
  </script>
</head>
<body>

<div id="container">
  <div id="left">
    <img src="${pageContext.request.contextPath}/img/login.jpg" alt="로그인 이미지" width="100%" height="100%">
  </div>

  <div id="right">
    <form action="${pageContext.request.contextPath}/Login" method="post" id="box">
      <div id="box1">
        <span>LOGIN</span>
        <input type="text" name="id" placeholder="아이디" id="userId" required> <br/>
        <input type="password" name="password" placeholder="비밀번호" required> <br/>
      </div>

      <div id="box2">
        <label><input type="checkbox" id="saveId"> 아이디 저장</label>
        <label><input type="checkbox"> IP보안접속</label>
      </div><br>

      <div id="box3">
        <input type="submit" id="btn" value="로그인"><br><br>
        <a href="./newUser.jsp"><b>회원가입</b></a>
        <a href="#"><b>아이디 / 비밀번호 찾기</b></a>
      </div>
    </form>
  </div>
</div>

</body>
</html>
