<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>The Calen</title>
  <link rel="stylesheet" href="../../css/loginPage.css" />
  <link rel="stylesheet" href="../../css/common.css" />
</head>
<body>
  <section id="introductionContainer">
    <h1 id="title">The<br />Calen</h1>
    <img src="../../src/pictures/loginPicture.svg" alt="The Calen Picture" id="picture" />
  </section>
  <main id="mainContainer">
    <form action="../actionJsp/loginAction.jsp" id="contentsContainer" onsubmit="return checkLoginValidEvent(event)">
      <h3 id="loginText">로그인</h3>
      <article id="inputContainer">
        <input type="text" placeholder="아이디" class="inputBox" id="id" name="id" required autofocus />
        <input type="password" placeholder="비밀번호" class="inputBox" id="pw" name="pw" required />
      </article>
      <article id="additionalBtnContainer">
        <a href="./registerPage.jsp" class="additionalText">회원가입</a>
        <a href="./findMyInfoPage.jsp" class="additionalText">아이디/비밀번호 찾기</a>
      </article>
      <input type="submit" value="로그인" id="loginBtn" />
    </form>
  </main>
  <script src="../../js/checkValid.js"></script>
</body>
