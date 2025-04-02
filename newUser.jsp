<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>직원 관리 시스템 - AJAX RESTful 스타일</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        #newUser{
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
       #top{
        margin-bottom: 30px;
       }
       .btm button{
        width: 60px;
        height: 40px;
        margin-left: 30px;
       }
       a{
        line-height: 30px;
        display: inline-block;
        border: 1px solid #d0d0d0;
        padding: 0px 10px;
        transition: 1s;
        border-radius: 10px;
        
       }
       hr{
        width: 95%;
        margin: auto;
       }
       .section {
  width: 1327px;
  margin: 20px auto;
}

.section-title {
  display: block;
  font-weight: bold;
  font-size: 16px;
  margin-bottom: 5px;
  text-align: left;
}

textarea {
  width: 100%;
  height: 282px;
  font-size: 15px;
  resize: none;
}

    </style>
</head>
<body>
    <div style= "position: fixed;
    top: 0;
    left: 0;
    height: 80px;
    width: 100%;
    background-color: rgba(52, 34, 211, 0.5);
    z-index: 1;
  ">
      </div>
<div id="newUser">
    <div class="top">
        <br><br>
        <h1>회원가입</h1>
        <br>
        <hr>
        <br>
        <p style="font-size: 18px;">회원 가입은 실명을 원칙으로 하며, 기재 사항이 허위 일 경우 통보 없이 삭제 또는 제명 처리 될 수 있습니다.<br>
            아래의 사내 인트라넷 / 웹메일 / 웹하드 이용약관에 동의하셔야 가입하실 수 있습니다
        </p>
        <br>
    </div>	
    <!-- 가입조건 영역 -->
        <div class="section">
            <label class="section-title">** 가입조건 **</label>
            <textarea readonly>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Nam, consequatur? Voluptates fuga, facere explicabo consequuntur, doloribus atque vero reiciendis provident minima aliquam cumque nisi dolor placeat quasi voluptatum autem quo!
            Nisi eum sequi ab illum animi enim dolor magnam saepe laudantium, repellendus velit omnis et necessitatibus vero, architecto consectetur quos tenetur eveniet non. Molestias suscipit dolore at, unde aperiam illum?
            Unde velit minima laborum. Consequuntur ipsa quisquam eum doloribus, ipsam debitis consequatur, totam pariatur dolor libero officiis placeat fugiat rem iusto delectus error, unde odio reprehenderit minus accusamus. Totam, sed!
            Doloribus quod repellendus, architecto aliquam laboriosam voluptatem officiis, dicta itaque quisquam minus eum culpa nesciunt iure pariatur optio deleniti ipsum omnis. Fuga ut minima quod cum tenetur, laudantium possimus similique.
            Quo illum explicabo laboriosam consectetur iusto quidem sequi quod nostrum libero reprehenderit cumque nulla molestiae vel, ea nemo veritatis nisi quam odio facere? Corrupti dolores, aspernatur pariatur rem perferendis impedit!
            Quis, tempore adipisci! Quod vel nihil unde quasi laboriosam reprehenderit facere est possimus eveniet? Quisquam hic facilis laboriosam totam maxime. Illum id aspernatur saepe, dignissimos quia ratione dolore nulla ea.
            Nemo aperiam velit nulla pariatur veritatis mollitia odio porro aliquam aut! Incidunt fugit mollitia, voluptate nihil asperiores consequatur odio reprehenderit, magnam nemo obcaecati doloribus architecto saepe molestias sed dolore autem.
            Nostrum itaque dolorum earum facere blanditiis dolor, commodi ducimus fuga atque, quidem, temporibus magni harum laborum illo et inventore dolore minima! Nesciunt sequi velit modi quibusdam omnis, repellendus numquam. Vitae.
            Minus possimus harum similique, suscipit doloremque adipisci natus velit nemo porro reprehenderit qui mollitia modi ut esse ipsa sunt, eveniet itaque architecto quasi exercitationem? Amet, corporis. Aliquid quaerat magnam voluptate.
            Quas rerum obcaecati inventore dolorum fugit vel asperiores modi excepturi neque dolor ut, quam nam optio quo error. Incidunt optio tenetur saepe perspiciatis nobis accusantium recusandae, delectus eveniet voluptatem deserunt!</textarea>
        </div>
  
  <!-- 개인정보 동의 영역 -->
        <div class="section">
            <label class="section-title">** 개인정보 동의 **</label>
            <textarea readonly>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Id, eaque nesciunt illum nemo praesentium aliquam enim fugit? Repudiandae beatae perspiciatis atque ducimus impedit cum, veniam fuga, nam, iste enim dignissimos?
            Iusto quam ratione ut quae voluptatum, saepe quo molestiae laborum unde architecto iure, qui tempore modi asperiores quibusdam odio ipsum accusamus pariatur. Voluptas, aut doloribus architecto maxime doloremque eligendi debitis?
            Ducimus temporibus in officia nemo, voluptate neque. Quisquam corporis dicta consequuntur dolore. Porro, laboriosam? Pariatur, exercitationem! Voluptatibus distinctio explicabo ut. Nam quam sapiente, eum est aut deserunt tenetur veritatis perferendis.
            Voluptate voluptates reiciendis dolorum corporis commodi. Blanditiis, dicta ad consequuntur magni optio similique minima neque quod nihil vitae, rem eum adipisci harum est pariatur amet accusamus corrupti molestias ex. Minima.
            Porro, cupiditate. Cupiditate consequatur inventore cum molestiae corrupti voluptatum necessitatibus dolorem, obcaecati eveniet earum impedit pariatur quis facilis fuga commodi, accusamus voluptatibus illo! Ipsa eius vel quam quos velit eos.
            Cumque, iste atque. Nostrum, ipsa assumenda aliquam explicabo perferendis rem at in quod ipsum ex perspiciatis hic. Repellendus ipsam debitis possimus, voluptate soluta est inventore optio, cumque nulla, blanditiis id.
            Soluta ad at, dolore, quae mollitia unde voluptatibus delectus aut tempore dignissimos alias! Quia cupiditate animi deleniti quidem vitae voluptate doloremque error a voluptas culpa aperiam laborum, sit illum veniam!
            Totam, ea dolores. Velit est dicta amet animi, omnis unde autem laboriosam natus quidem eveniet ducimus perspiciatis, sit tempora. Ipsa quod consequatur mollitia deleniti impedit, fugit earum nam quisquam perspiciatis?
            Quibusdam laborum magni obcaecati mollitia necessitatibus molestias quis hic quo eligendi voluptates, iste porro! Reprehenderit labore libero suscipit harum magnam officia fuga, cumque asperiores velit nostrum atque porro doloribus! Minima!
            Enim consectetur necessitatibus temporibus magnam id, error commodi corrupti debitis consequatur in corporis inventore autem ut optio ratione molestias delectus possimus cupiditate quidem. Tempore impedit molestias aliquid ullam dolore deserunt.</textarea>
        </div>
  
    <form action="" class="btm" style="margin: 20px auto; ">
        <a href="./yesUser.jsp">동의</a>
        <a href="./login.jsp">취소</a>
    </form>
</div>

</body>
</html>
