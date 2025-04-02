<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>직원 관리 로그인</title>
    <style>
    *{
        padding: 0;
        margin: 0;
    }
    a {
        color: inherit;         /* 글자색 상속 */
        text-decoration: none;  /* 밑줄 제거 */
        cursor: pointer;
    }
   body{
        background-color: #f0f0f0;
    }
    #yesUser{
            margin: 30px auto 0;
            z-index: 99;
            position: relative;
            text-align: center;
            width: 98%;
            height: 100vh;
            border-radius: 10px;
            border: 1px solid #808080;
            background-color: white;
            padding-bottom: 100px;
        }
        table{
            width: 98%;
            box-sizing: border-box;
            margin: auto;
            border: 1px solid black;
            border-collapse: collapse;
            /* 핵심 테이블 이중선을 없애고 하나의 선으로 만들어 엑셀의표처럼 표현해줌 */
            text-align: left;
        }
        tr,th,td{
            padding: 7px;
            border: 1px solid black;
        }
        input{
            width: 150px;
            height: 25px;
            font-size: 15px;
        }
        .top{
            width: 98%;
            height: 50px;
            border-radius: 10px;

            background-color: rgba(160, 199, 231, 0.5);
            margin: 10px auto 3px; 
            text-align: left;
        }
        .btn1{
            padding: 2px 5px; 
            background-color: rgba(234, 187, 248, 0.5); 
            border: 1px solid #808080; 
            border-radius: 10px;
        }
        .btn1:hover{
            background-color: #d4d3d3;
        }
   </style>


   <script>

   </script>


</head>
<body>
    <!-- 윗상당 공간 꾸밈용 -->
    <div style= "position: fixed; top: 0; left: 0; height: 80px; width: 100%; background-color: rgba(52, 34, 211, 0.5); z-index: 1;"></div>
    <!-- 회원 가입 내용 작성  -->
     <form action="">
    <div id="yesUser">
        <div class="top">
            <p>※ (<font color="red">*</font> )표시는 필수 입력 항목입니다.</p>
            <p style="color: blue;">※ 관리자의 승인을 받은뒤 정상적인 사용이 가능합니다.</p>
        </div>
        <table>
            <tr>
                <th>이름(실명)(*)</th>
                <td><input type="text"> (한글 2~4자,영어 4~8자 / 띄어쓰기 없음)</td>
            </tr>
            <tr>
                <th>아이디(*)</th>
                <td><input type="text"> @pomtex.co.kr <button type="submit" class="btn1">ID중복확인</button>
                    <p style="font-size: 13px; color:blue;">(3자 이상 20자 이하 / 영문 및 숫자 조합 / 띄어쓰기 없음)</p>
                </td>
            </tr>
            <tr>
                <th>비밀번호(*)</th>
                <td><input type="text">
                    <p style="font-size: 13px; color: blue;">☞ 8자 이상 20자 이하, 영문소문자+(영문대문자 or 특수문자) 조합</p>
                </td>
            </tr>
            <tr>
                <th>비밀번호 재확인(*)</th>
                <td><input type="text">확인을 위해 다시 한 번 입력합니다.</td>
            </tr>
            <tr>
                <th>비밀번호 재발급 질문(*)</th>
                <td><input type="text" style="width: 300px;"> (예 : 좋아하는 색깔은?)</td>
            </tr>
            <tr>
                <th>비밀번호 재발급 답변(*)</th>
                <td><input type="text " style="width: 300px;"> (예 : 파란색)</td>
            </tr>
            <tr>
                <th>보조E-mail(*)</th>
                <td><input type="text" style="width: 300px;"> 비밀번호 재발급시 사용됩니다.</td>
            </tr>
            <tr>
                <th>메일수신여부(*)</th>
                <td><select name="m_isremail" style="width: 150px; height: 25px;">
                    <option value="Y">수신함</option>
                    <option value="N">수신하지않음</option>
                </select>
                서비스이용에 관련된 안내를 받아보실 수 있습니다.
            </td>
            </tr>
            <tr>
                <th>해든폰(PCS)</th>
                <td><input type="text" name="m_mobile_1" size="4" maxlength="4" style="width: 60px; text-align: center;"> -
                    <input type="text" name="m_mobile_1" size="4" maxlength="4" style="width: 60px; text-align: center;"> -
                    <input type="text" name="m_mobile_1" size="4" maxlength="4" style="width: 60px; text-align: center;"></td>
            </tr>
            <tr>
                <th>직장 전화번호</th>
                <td><input type="text" name="m_mobile_1" size="4" maxlength="4" style="width: 60px; text-align: center;"> -
                    <input type="text" name="m_mobile_1" size="4" maxlength="4" style="width: 60px; text-align: center;"> -
                    <input type="text" name="m_mobile_1" size="4" maxlength="4" style="width: 60px; text-align: center;"></td>
            </tr>
            <tr>
                <th>사진</th>
                <td><input type="file" name="m_file1" style="min-width: 250px; padding-bottom: 3px;"></input></td>
            </tr>
            
        </table>
    
    <div style="margin-top: 20px;">
        <input type="submit" value="회원가입" style="width: 100px; height: 30px; border-radius: 5px; border: 1px solid #808080;"  >
        <input type="button" value="취소" onclick="location.href='./login.jsp'" style="width: 50px; height: 30px; border-radius: 5px; border: 1px solid #808080;"> 
    </div>
</div>
</form>

</body>
</html>
