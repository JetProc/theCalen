<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Find My Information</title>
    <link rel="stylesheet" href="../../css/findMyInfoPage.css" />
    <link rel="stylesheet" href="../../css/common.css" />
</head>
<body>
    <div id="introductionContainer">
    <h1 id="title">The<br />Calen</h1>
    <img src="../../src/pictures/loginPicture.svg" alt="The Calen Picture" id="picture" />
    </div>
    <main id="mainContainer">
    <form action="../actionJsp/findMyInfoAction.jsp" id="findIdcontentsContainer" onsubmit="return checkFindIdValidEvent(event)">
        <h3 class="findText">아이디 찾기</h3>
        <article class="inputContainer">
        <input type="text" placeholder="이름" class="inputBox" id="name" name="name" required autofocus />
        <input type="tel" placeholder="핸드폰 번호" class="inputBox" id="phonenum" name="phonenum" maxlength="13" required oninput="autoHyphen(this)"/>
        </article>
        <input type="submit" value="아이디 찾기" class="findBtn" />
    </form>
    <form action="../actionJsp/findMyInfoAction.jsp" id="findPwcontentsContainer" onsubmit="return checkFindPwValidEvent(event)">
        <h3 class="findText">비밀번호 찾기</h3>
        <article class="inputContainer">
        <input type="text" placeholder="아이디" class="inputBox" id="id" name="id" required />
        <input type="text" placeholder="이름" class="inputBox" id="name" name="name" required />
        <input type="tel" placeholder="핸드폰 번호" class="inputBox" id="phonenum" name="phonenum" maxlength="13" required oninput="autoHyphen(this)"/>
        </article>
        <input type="submit" value="비밀번호 찾기" class="findBtn" />
    </form>
    <a href="./loginPage.jsp" id="goBackBtn" class="additionalText">뒤로가기</a>
    </main>
    <script src="../../js/checkValid.js"></script>
</body>
